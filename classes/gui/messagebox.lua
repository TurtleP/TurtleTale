messagebox = class("messagebox", guiBase)

function messagebox:initialize(x, y, flags)
	guiBase.initialize(self, x, y, 200, 128, flags)

	self.gui = {}
	if self.type == "YESNO" then
		table.insert(self.gui, imagebutton:new(buttonImage, CONTROLS["accept"], "Yes", self.width * 0.4, self.y + 24 + self.height * 0.65, 48, 12, { padding = 2, func = function()
			self.file:delete()
			self.remove =true
		end}))
		table.insert(self.gui, imagebutton:new(buttonImage, CONTROLS["jump"], "No", self.x + 4 + self.width * 0.7, self.y + 24 + self.height * 0.65, 48, 12, { padding = 2, func = function()
			self.remove = true
		end}))
	end
end

function messagebox:draw()
	love.graphics.setColor(63, 25, 0, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.width, 24)

	love.graphics.setColor(106, 47, 7)
	love.graphics.rectangle("fill", self.x, self.y + 24, self.width, self.height - 24)

	love.graphics.setColor(255, 255, 255)
	love.graphics.print(self.title, self.x + 4, self.y + (24 - gameFont:getHeight()) / 2)

	love.graphics.print(self.body, self.x + 4, self.y + 28)

	for k, v in pairs(self.gui) do
		v:draw()
	end
end

function messagebox:keypressed(key)
	for k, v in pairs(self.gui) do
		v:keypressed(key)
	end
end