megabat = class("megabat", entity)

local megaBatImage = love.graphics.newImage("graphics/game/enemies/bat-boss.png")
local megaBatQuads = {}
for y = 1, 2 do
	for x = 1, 3 do
		table.insert(megaBatQuads, love.graphics.newQuad((x - 1) * 30, (y - 1) * 30, 30, 30, megaBatImage:getWidth(), megaBatImage:getHeight()))
	end
end

--[[
	== AI DETAILS ==
	Flies back and forth
	Will occasionally dive at the player

	< 1/2 health:
	shoot sonar blasts at random possible times

	Damaged:
	Player must punch the bat
	How? When it dives!
--]]

local flapSound = love.audio.newSource("audio/flap.ogg", "static")

function megabat:initialize(layer, x, y)
	entity.initialize(self, layer, x, y, 30, 30)

	self.spawns = {self.origin.x, -self.width}

	self.mask = { false, true }

	self.category = 9

	self.health = 4
	self.maxHealth = 4

	self.hud = hud:new(self, state:get("map").width - (9 * self.maxHealth + 18))

	self.timer = 0
	self.quadi = 1

	self.angle = 0

	self.animation =
	{
		fly = {4, 5, 6, 5}
	}

	self.state = "fly"

	self.diveTimer = math.random(2, 3)
	self.diveTimes = math.random(1, 2)

	self.invincibleTimer = 0
	self.invincible = false

	self.sonicTimer = math.random(1, 3)

	self.minionTimer = math.random(3, 6)

	self.layer = layer
end

function megabat:animate(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = self.animation[self.state][math.floor(self.timer % #self.animation[self.state]) + 1]
end

function megabat:update(dt)
	self.hud:update(dt)

	self:animate(dt)
	self:checkSplash()

	if event:isRunning() then
		return
	end

	local mul = self.scale
	if self.diving then
		mul = 1

		if self.speed.x < 0 then
			self:setScale(-1)
		else
			self:setScale(1)
		end
	end

	self.speed.x = (math.cos(self.angle) * 180) * mul
	self.speed.y = (math.sin(self.angle) * 180) * mul

	local player = state:get("player")

	if self.quadi == 5 then
		flapSound:play()
	end

	if self.diveTimes > 0 then
		self.diveTimer = self.diveTimer - dt
		if self.diveTimer < 0 then
			self.angle = math.atan2(player.y - self.y, player.x - self.x)
			self.diveTimes = self.diveTimes - 1

			self.diving = true
		end
	else
		if self.y > SCREEN_HEIGHT then
			self.diving = false
			self.diveTimes = math.random(1, 2)
			self.diveTimer = math.random(2, 3)

			self.y = self.origin.y
			self.x = self.spawns[math.random(#self.spawns)]

			self.angle = 0
		end
	end

	if not self.diving then
		if self.x + self.width < 0 then
			self:setScale(1)
		elseif self.x > 320 then
			self:setScale(-1)
		end

		if distance(self.x, self.y, player.x, player.y) > 64 and self.health < self.maxHealth then
			self.sonicTimer = self.sonicTimer - dt
			if self.sonicTimer < 0 then
				local angle = math.atan2((player.y + (player.height / 2)) - self.y, (player.x + (player.width /2)) - self.x)

				local add = self.width
				if self.scale < 0 then
					add = 0
				end
				sonicblast:new(self.x + add, self.y, vector(math.cos(angle) * 180, math.sin(angle) * 120))
				self.sonicTimer = math.random(1, 3)
			end
		end

		self.minionTimer = self.minionTimer - dt
		if self.minionTimer < 0 then
			bat:new(self.layer, math.random(0, 320), -16, "fly")
			self.minionTimer = math.random(3, 6)
		end
	end

	if self.invincible then
		self.invincibleTimer = self.invincibleTimer + 10 * dt

		if self.invincibleTimer > 15 then
			self.invincible = false
			self.invincibleTimer = 0
		end
	end
end

function megabat:draw()
	self.hud:draw()

	if self.invincible and math.floor(self.invincibleTimer) % 2 == 0 then
		return
	end
	love.graphics.draw(megaBatImage, megaBatQuads[self.quadi], self.x, self.y, 0, self.scale, 1, self:getXOffset())
end

function megabat:punch(dir)
	if self.invincible then
		return
	end

	particle:new(self.layer, self.x, self.y + (self.height / 2) - 1, vector(-40, -64), {200, 0, 0})
	particle:new(self.layer, self.x, self.y + (self.height / 2) - 1, vector(40, -64), {200, 0, 0})

	self.health = math.max(self.health - 1, 0)
	if self.health == 0 then
		self:die()
		event:load("batdoor", CUTSCENES["batdoor"][1])
		container:new(152, -16)
	end

	self.invincible = true
end

function megabat:rightCollide(name, data)
	if name == "player" then
		return false
	end
end

function megabat:leftCollide(name, data)
	if name == "player" then
		return false
	end
end

function megabat:downCollide(name, data)
	if name == "player" then
		return false
	end
end

function megabat:upCollide(name, data)
	if name == "player" then
		return false
	end
end