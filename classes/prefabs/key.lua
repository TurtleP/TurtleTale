key = class("key")

local keyImage = love.graphics.newImage("graphics/game/key.png")
local keyQuads = {}
for i = 1, 6 do
	keyQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, keyImage:getWidth(), keyImage:getHeight())
end

function key:init(x, y)
	self.x = x
	self.y = y

	self.width = 16
	self.height = 10

	self.timer = 0
	self.quadi = 1

	self.parent = nil
	self.scale = 1

	self.moveSpeed = 128

	self.maxDelay = 0.02
	self.delay = self.maxDelay

	self.offsets = {0, self.width}
end

function key:adjust()
	local off = self.parent.x - self.width - 8
	if self.parent.scale < 0 then
		off = self.parent.x + self.parent.width + self.width / 2
	end
	self.x = off
	self.y = self.parent.y - self.height / 2
end

function key:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #keyQuads) + 1

	if not self.parent then
		local ret = checkrectangle(self.x, self.y, self.width, self.height, {"player"})

		if #ret > 0 then
			self.parent = ret[1][2]
			ret[1][2].key = self
			self.remove = true
		end
	else
		self.delay = self.delay - dt
		if self.delay > 0 then
			return
		else
			self.delay = self.maxDelay
		end
		
		local off = self.parent.x - self.width - 8
		if self.parent.scale < 0 then
			off = self.parent.x + self.parent.width + self.width / 2
		end

		if util.dist(self.x, self.y, self.parent.x, self.parent.y) > 32 then
			self.moveSpeed = 160
		else
			self.moveSpeed = 128
		end

		if self.x < off then
			self.x = math.min(self.x + self.moveSpeed * dt, off)
		elseif self.x > off then
			self.x = math.max(self.x - self.moveSpeed * dt, off)
		end

		if self.y > self.parent.y - self.height / 2 then
			self.y = math.max(self.y - self.moveSpeed * dt, self.parent.y - self.height / 2)
		elseif self.y < self.parent.y - self.height / 2 then
			self.y = math.min(self.y + self.moveSpeed * dt, self.parent.y - self.height / 2)
		end
	
		if self.x < self.parent.x then
			self.scale = 1
		elseif self.x > self.parent.x + self.parent.width then
			self.scale = -1
		end
	end
end

function key:draw()
	love.graphics.draw(keyImage, keyQuads[self.quadi], self.x + self:getOffset(), self.y, 0, self.scale)
end

function key:getOffset()
	if self.scale > 0 then
		return self.offsets[1]
	end
	return self.offsets[2]
end