ai = class("ai", entity)

function ai:init(x, y)
	entity.init(self, x, y)

	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.mask =
	{
		true, true, true,
		false, true, false
	}

	self.state = "idle"
	self.category = 6

	self.quadi = 1
	self.timer = 0

	self.active = true
	self.gravity = 480

	self.speedx = 0
	self.speedy = 0

	self.idleTime = math.random(1, 2)
	self.walkTime = math.random(2, 4)

	self.scale = 1
	self.offsets = {0, 0}
end

function ai:passiveThink(dt)
	if self.punched then
		return
	end

	if self.walkTime > 0 then
		self.walkTime = self.walkTime - dt
		self.speedx = 32 * -self.scale
	else
		self.speedx = 0
		if self.idleTime > 0 then
			self.idleTime = self.idleTime - dt
		else
			self.idleTime = math.random(1, 2)
			self.walkTime = math.random(2, 4)
		end
	end

	if self.speedx ~= 0 then
		self.state = "walk"
	else
		if not self.attacking then
			self.state = "idle"
		end
	end

	--check for gaps
	if self:checkGaps(dt) then
		self.speedx = 32 * -self.scale
		self:setDirection(-self.scale)
	end
end

function ai:checkGaps(dt)
	if self.walkTime > 0 then
		local math = self.x + self.width
		if self.speedx < 0 then
			math = self.x - self.width
		end
		return #checkrectangle(math + self.speedx * dt, self.y + self.height, self.width, self.height, {"tile"}) == 0
	end
end

function ai:drawTileCheck(dt)
	local math = self.x + self.width
	if self.speedx < 0 then
		math = self.x - self.width
	end
	love.graphics.rectangle("line", math, self.y + self.height, self.width, self.height)
end

function ai:upCollide(name, data)
	if name == "player" then
		return false
	end
end

function ai:rightCollide(name, data)
	if name == "player" then
		return false
	end

	if name == "tile" or name == "barrier" then
		self.speedx = 32 * -self.scale
		self:setDirection(-self.scale)
	end
end

function ai:downCollide(name, data)
	if name == "player" then
		return false
	end

	if name == "tile" and self.punched then
		self:die()
		return false
	end
end

function ai:leftCollide(name, data)
	if name == "player" then
		return false
	end

	if name == "tile" or name == "barrier" then
		self.speedx = 32 * -self.scale
		self:setDirection(-self.scale)
	end
end