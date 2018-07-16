crate = class("crate", entity)

function crate:initialize(layer, x, y, properties)
	entity.initialize(self, layer, x, y, 16, 16)

	self.category = 11
	self.gravity = 480

	self.mask = { true, true }

	self.offset = 0
	self.inWater = false

	for k, v in pairs(properties) do
		if type(k) == "string" then
			self[k] = v
		end
	end
end

function crate:update(dt)
	if not self.inWater then
		local inWater = self:checkSplash()
	
		if inWater then
			self.inWater = true
			self.origin.y = self.y
		end
	end

	if self.inWater then
		self.gravity = 0
		self.speed.y = 0

		self.offset = math.sin(love.timer.getTime() * 5) * 2
		self.y = self.origin.y + self.offset

		local player = state:get("player")
		if player.onCrate then
			if not player.jumping then
				player.y = self.y - player.height
				--player.x = self.x + self.speed.x * dt + player.speed.x * dt
			end
		end
		self:setSpeedX(16 * self.direction)
	else
		if self.speed.x > 0 then
			self.speed.x = math.max(self.speed.x - 64 * 0.5 * dt, 0)
		else
			self.speed.x = math.min(self.speed.x + 64 * 0.5 * dt, 0)
		end
	end
end

function crate:draw()
	love.graphics.draw(gameTilesImage, gameTilesQuads[157], self.x, self.y)
end

function crate:rightCollide(name, data)
	if name == "tile" then
		if self.inWater then
			self:die()
		end
	end
end