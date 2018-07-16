spider = class("spider", entity)

local spiderImage = love.graphics.newImage("graphics/game/enemies/spider.png")
local spiderQuads = {}
local states = {{"idle", 3}, {"jump", 3}, {"walk", 4}}
for y = 1, 3 do
	spiderQuads[states[y][1]] = {}
	for x = 1, states[y][2] do
		table.insert(spiderQuads[states[y][1]], love.graphics.newQuad((x - 1) * 23, (y - 1) * 16, 22, 16, spiderImage:getWidth(), spiderImage:getHeight()))
	end
end

function spider:initialize(layer, x, y)
	entity.initialize(self, layer, x, y, 22, 16)

	self.mask =
	{
		true, false, true,
		false, false, false,
		true
	}

	self.idleTime = math.random(1, 2)
	self.walkTime = math.random(2, 4)

	self.gravity = 480
	self.timer = 0
	self.quadi = 1

	self.chase = false
	self.jumpTimer = 0.5

	self.category = 6

	self.animationRules =
	{
		jump = {stop = true}
	}
end

function spider:animate(dt)
	if self.animationRules[self.state] then
		local rule = self.animationRules[self.state]
		if rule.stop and self.quadi == #spiderQuads[self.state] then
			return
		end
	end
	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #spiderQuads[self.state]) + 1
end

function spider:update(dt)
	self:animate(dt)

	self:checkDeath()
	self:checkSplash()
	
	local check = checkrectangle(self.x + (self.width * self.scale) + self.speed.x * dt, self.y, self.width, self.height, {"player"})
	if #check > 0 then
		self.chase = true
	end

	if self.chase then
		self.jumpTimer = self.jumpTimer - dt
		if self.jumpTimer < 0 then
			self:jump()
			self.jumpTimer = 1
		end

		return
	end

	if self.walkTime > 0 then
		self.walkTime = self.walkTime - dt

		local math = self.x + self.width
		if self.scale < 0 then
			math = self.x - 16
		end
		local check = checkrectangle(math + self.speed.x * dt, self.y + self.height, 16, 8, {"tile"})
		if #check == 0 then
			self:setScale(-self.scale)
		end

		self.speed.x = 32 * self.scale
	else
		self.speed.x = 0
		if self.idleTime > 0 then
			self.idleTime = self.idleTime - dt
		else
			self.idleTime = math.random(1, 2)
			self.walkTime = math.random(2, 4)
		end
	end

	if self.speed.x ~= 0 then
		self:setState("walk")
	else
		self:setState("idle")
	end
end

function spider:draw()
	love.graphics.draw(spiderImage, spiderQuads[self.state][self.quadi], self.x, self.y, 0, self.scale, 1, self:getXOffset())
end

function spider:jump()
	if not self.jumping then
		self.speed = vector(80 * self.scale, -120)
		self:setState("jump")
		self.jumping = true
	end
end

function spider:rightCollide(name, data)
	if name == "tile" or name == "barrier" then
		self.speed.x = -self.speed.x
		self:setScale(-self.scale)
	end

	if name == "player" then
		return false
	end
end

function spider:leftCollide(name, data)
	if name == "tile" or name == "barrier" then
		self.speed.x = -self.speed.x
		self:setScale(-self.scale)
	end

	if name == "player" then
		return false
	end
end

function spider:downCollide(name, data)
	if name == "tile" then
		if self.jumping then
			self.speed.x = 0
			self:setState("idle")

			local player = state:get("player")

			if player.x > self.x then
				self:setScale(1)
			else
				self:setScale(-1)
			end

			self.jumping = false
		end
	end

	if name == "player" then
		return false
	end
end

function spider:upCollide(name, data)
	if name == "player" then
		return false
	end
end