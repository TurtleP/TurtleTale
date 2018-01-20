entity = class("entity")

function entity:initialize(world, x, y, width, height)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	self.scale = 1

	self.category = 0
	self.mask = { false }

	table.insert(world, self)
end

function entity:speak()
	
end