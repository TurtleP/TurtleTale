tile = class("tile")

function tile:initialize(layer, x, y, width, height, properties)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	self.category = 1

	table.insert(layer, self)
end

function tile:draw()
	--love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end