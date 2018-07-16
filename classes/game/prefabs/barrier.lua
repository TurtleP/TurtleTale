barrier = class("barrier")

function barrier:initialize(layer, x, y, width, height)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	self.active = true
	self.static = true
	
	self.category = 1
	
	table.insert(layer, self)
end