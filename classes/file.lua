local file = class("file")

file.ID = 0

function file:initialize(data)
	file.ID = file.ID + 1

	self.x = (BOTSCREEN_WIDTH - 192) / 2
	self.y = (SCREEN_HEIGHT - 160) / 2 + (file.ID - 1) * 56
	
	self.width = 192
	self.height = 48

	self.isNew = (data.date == nil)

	self.time = 0
	self.ID = file.ID
end

function file:tick(dt)
	self.time = self.time + dt
end

function file:update(dt)

end

function file:draw()
	if self.isNew then
		love.graphics.print("NEW FILE", self.x + (self.width - gameFont:getWidth("NEW FILE")) / 2, self.y + (self.height - gameFont:getHeight()) / 2)
	else

	end
end

function file:select()
	state:change("game")
	
	if self.isNew then
		save:encode(self.ID)
	else
		save:import()
	end
end

function file:keypressed(key)
	if key == "a" then
		self:select()
	end
end

return file