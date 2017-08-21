spider = class("spider", ai)

local spiderImage = love.graphics.newImage("graphics/game/enemies/spider.png")
local spiderQuads = {}

local states = {{"idle", 3}, {"jump", 3}, {"walk", 4}}
for y = 1, 3 do
	spiderQuads[states[y][1]] = {}
	for x = 1, states[y][2] do
		table.insert(spiderQuads[states[y][1]], love.graphics.newQuad((x - 1) * 23, (y - 1) * 16, 22, 16, spiderImage:getWidth(), spiderImage:getHeight()))
	end
end

function spider:init(x, y)
	ai.init(self, x, y)

	self.x = x
	self.y = y
	self.width = 14
	self.height = 14

	self.mask = {true}

	self.gravity = 600

	self.active = true

	self.speedx = 0
	self.speedy = 0

	self.timer = 0
	self.quadi = 0

	self.state = "walk"
	self.offsets = {0, self.width}

	self.runSpeed = 64
	self.walkSpeed = 48

	self.chaseTimer = 3
	self.jumpTimer = math.random(1, 2)
end

function spider:update(dt)
	ai.update(self, dt)

	local rate = 6
	if not self.attacking then
		self.speedx = self.walkSpeed * -self.scale

		ai.passiveThink(self, dt)
	else
		rate = 9
		
		if self.state ~= "jump" then
			if self.attacking.x > self.x then
				self.speedx = self.runSpeed
			elseif self.attacking.x < self.x then
				self.speedx = -self.runSpeed
			else
				self.state = "idle"
				self.speedx = 0
			end
		end

		if self:checkGaps(dt) then
			self:jump()
		else
			--follow player for a while
			self.chaseTimer = self.chaseTimer - dt
			if self.chaseTimer < 0 then
				self.attacking = nil
			end

			self.jumpTimer = self.jumpTimer - dt
			if self.jumpTimer < 0 then
				self:jump()
				self.jumpTimer = math.random(1, 2)
			end
		end
	end

	self.timer = self.timer + rate * dt
	self.quadi = math.floor(self.timer % #spiderQuads[self.state]) + 1
	
	--line of sight, fam
	local ret = checkrectangle(self.x + self.width, self.y, 80, self.height, {"player"})
	if #ret > 0 then
		self.attacking = ret[1][2]
		self.chaseTimer = 1.5
	end

	self.dt = dt
end

function spider:jump()
	if self.speedy == 0 then
		self.speedy = -180
		self.speedx = 96 * -self.scale
		self.state = "jump"
	end
end

function spider:upCollide(name, data)
	ai.upCollide(self, name, data)

	self:die()
end

function spider:leftCollide(name, data)
	if not self.attacking then
		ai.leftCollide(self, name, data)
	end
end

function spider:rightCollide(name, data)
	if not self.attacking then
		ai.rightCollide(self, name, data)
	end
end

function spider:downCollide(name, data)
	ai.downCollide(self, name, data)

	if name == "tile" then
		self.state = "walk"
	end
end

function spider:draw()
	love.graphics.draw(spiderImage, spiderQuads[self.state][self.quadi], self.x + self:getOffset(), self.y - 2, 0, self.scale)
end