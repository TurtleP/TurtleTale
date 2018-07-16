tardigrade = class("tardigrade", entity)

function tardigrade:initialize(layer, x, y)
	entity.initialize(self, layer, x, y, 16, 8)

	self.mask = { true, true }

	self.category = 9
	self.gravity = 480
end

function tardigrade:draw()
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end