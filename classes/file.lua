file = class("file")

function file:initialize(y, data)
	self.x = (BOTSCREEN_WIDTH - 192) / 2
	self.y = y
	
	self.width = 192
	self.height = 48

	self.isNew = (#data == 0)
end

function file:draw()
	if self.isNew then
		love.graphics.print("NEW FILE", self.x + (self.width - gameFont:getWidth("NEW FILE")) / 2, self.y + (self.height - gameFont:getHeight()) / 2)
	else

	end
end