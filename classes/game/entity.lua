entity = class("entity")

function entity:initialize(layer, x, y, width, height)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	self.scale = 1

	self.category = 0
	self.mask = { false }
	self.active = true

	self.gravity = 0
	self.speed = vector(0, 0)

	if layer then
		table.insert(layer, self)
	end
end

function entity:speak()
	
end

function entity:update(dt)

end

function entity:draw()

end

function entity:getXOffset()
	local offset = 0
	if self.scale < 0 then
		offset = self.width
	end
	
	return offset
end