hermitboss = class("hermitboss", hermit)

local sparkleImage = love.graphics.newImage("graphics/game/sparkle.png")
local sparkleQuads = {}
for i = 1, 8 do
	sparkleQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, sparkleImage:getWidth(), sparkleImage:getHeight())
end

function hermitboss:init(x, y)
	hermit.init(self, x, y)

	self.x = x
	self.y = y

	self.width = 24
	self.height = 24

	self.scale = 2

	self.health = 6

	self.state = "idle"

	self.offsets = {0, self.width + 6}

	self.stunned = false

	self.wakeDelay = 0

	self.sparklei = 1
	self.sparkleTimer = 0

	self.rockTimerMax = 0.1
	self.rockTimer = self.rockTimerMax

	self.runSpeed = 80

	self.type = "hermit"

	self.jumping = false
	self.charging = false
	self.knockOuts = 0

	self.start = false
end

function hermitboss:update(dt)
	self:updateDirection()

	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #self.quad[self.state]) + 1

	if not self.start then
		return
	end

	local player = objects["player"][1]
	
	if not self.stunned then
		if self.wakeDelay == 0 then
			local xpos = self.x - (self.width * 3)
			if self.scale < 0 then
				xpos = self.x + self.width
			end
			local ret = checkrectangle(xpos, self.y, self.width * 3, self.height, {"player"})

			if #ret > 0 then
				self.charging = true
				if self.scale < 0 then
					self.speedx = self.runSpeed
				else
					self.speedx = -self.runSpeed
				end
			end

			if not self.charging then
				self:passiveThink(dt)
			end

			self.state = "walk"
		end
	else
		self.wakeDelay = math.max(self.wakeDelay - dt, 0)

		self.sparkleTimer = self.sparkleTimer + 8 * dt
		self.sparklei = math.floor(self.sparkleTimer % #sparkleQuads) + 1 --probably won't work

		if self.wakeDelay <= 0 then
			self.stunned = false
			self.rockTimer = self.rockTimerMax
			self.makeItRain = false
			self.punched = false
		end

		if self.makeItRain then
			self.rockTimer = self.rockTimer - dt
			if self.rockTimer < 0 then
				table.insert(prefabs, rock:new(math.random(0, util.getWidth()), 0))
				self.rockTimer = self.rockTimerMax
			end
		end

		self.state = "idle"
	end

	if self.invincible then
		self.invincibleTimer = self.invincibleTimer + 8 / 0.8 * dt

		if self.invincibleTimer > 8 then
			self.invincible = false
			self.invincibleTimer = 0
		end
	end
end

function hermitboss:draw()
	if not self.invincible or (self.invincible and math.floor(self.invincibleTimer) % 2 ~= 0 and self.invincibleTimer > 0) then
		love.graphics.draw(self.graphic, self.quad[self.state][self.quadi], (self.x - 4) + self:getOffset(), self.y - 8, 0, self.scale, 2)
	end

	if self.stunned then
		love.graphics.draw(sparkleImage, sparkleQuads[self.sparklei], (self.x - 4) + self:getOffset(), self.y)
	end
end

function hermitboss:leftCollide(name, data)
	if name == "tile" then
		if self.charging then
			if not self.stunned then
				self:stun()
			end
			self.speedx = -(self.speedx / 2)
			return false
		else
			self.speedx = 32 * -self.scale
			self:setDirection(-self.scale)
		end
	else
		return hermit.leftCollide(self, name, data)
	end
end

function hermitboss:rightCollide(name, data)
	if name == "tile" then
		if self.charging then
			if not self.stunned then
				self:stun()
			end
			self.speedx = -(self.speedx / 2)
			return false
		else
			self.speedx = 32 * -self.scale
			self:setDirection(-self.scale)
		end
	else
		return hermit.leftCollide(self, name, data)
	end
end

function hermitboss:downCollide(name, data)
	if self.stunned then
		self.speedx = 0
	end

	if name == "player" then
		return false
	elseif name == "tile" then
		if not self.start then
			self.start = true
		end

		if self.health == 0  then
			self:die()
			table.insert(objects["container"], container:new((tiled:getWidth() * 16) / 2, self.y))
		end
	end
end

function hermitboss:stun()
	self.speedy = -120
	self.wakeDelay = math.random(3, 4)
	self.stunned = true
	shakeValue = 3
	self.jumping = false

	self.knockOuts = self.knockOuts + 1
	if self.knockOuts % 2 == 0 and self.health < 5 then
		self.makeItRain = true
	elseif self.knockOuts % 3 == 0 and self.health < 3 then
		for i = 1, math.random(4) do
			table.insert(objects["hermit"], hermit:new(math.random(144, 240), 0, {evil = true, checkGaps = false}))
		end
	end

	self.charging = false
end

function hermitboss:getPunched(dir)
	if not self.stunned then
		return
	end

	hermit.getPunched(self, dir)
	self.invincible = true
end

function hermitboss:die()
	hermit.die(self)

	shakeValue = 5
end