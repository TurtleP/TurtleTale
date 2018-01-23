door = class("door")

function door:initialize(layer, x, y, properties)
	self.x = x
	self.y = y

	if not properties.link then
		return
	end

	self.useRectangle = userectangle:new(self.x, self.y, 16, 16, function(player)
		local map = state:get("map")
		map:changeLevel(state.states["game"], properties.link) 
	end, false, true)

	table.insert(layer, self)
end

function door:update(dt)
	self.useRectangle:update(dt)
end

function door:draw()
	self.useRectangle:draw()
end