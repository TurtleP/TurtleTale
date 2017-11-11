block = class("block")

function block:init(x, y, properties)
	self.x = x
	self.y = y

	self.originX = x
	self.originY = y

	self.width = 16
	self.height = 32

	self.active = true
	self.static = true

	self.speedx = 0
	self.speedy = 0

	self.mask = { false }

	local distance = 0
	if properties.length then
		distance = properties.length
	end
	self.distance = distance

	local open = true
	if properties.open ~= nil then
		open = properties.open
	end
	self.open = open

	self.category = 1

	self.moveSpeed = 32

	self.customScissor = {tiled:getOffset() + self.x, self.originY + self.height, self.width, self.height}
end

function block:update(dt)
	if not self.open then
		if self.y + self.height < self.originY + self.height + self.distance then
			self.speedy = self.moveSpeed
		else
			self.speedy = 0
		end
	else
		if self.y > self.originY then
			self.speedy = -self.moveSpeed
		else
			self.speedy = 0
		end
	end

	self.y = self.y + self.speedy * dt
end

function block:unlock(open)
	self.open = open
end

function block:draw()
	for i = 1, 2 do
		love.graphics.draw(gameTiles, tileQuads[225], self.x, self.y + (i - 1) * 16)
	end
end