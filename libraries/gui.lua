gui = class("gui")

function gui:init(...)
	local arg = {...}

	self.t = arg[1]

	self.x = arg[2]
	self.y = arg[3]

	self.width = arg[4]
	self.height = arg[5]
	self.title = arg[6]

	if self.t == "list" then
		self.list = arg[7]
		self.currentItem = 1

		self.width = gameFont:getWidth(self.list[self.currentItem]) + (gameFont:getWidth(" ") * 6)

		self.previous = gui:new("button", self.x, self.y, 8, 14, "<L")
		self.next = gui:new("button", self.x + self.width - gameFont:getWidth("R>"), self.y, 8, 14, "R>")
	end
end

function gui:update(dt)

end

function gui:draw()
	if self.t == "list" then
		love.graphics.print(self.title, self.x, self.y)

		love.graphics.push()
		love.graphics.translate(gameFont:getWidth(self.title) + 4, 0)

		love.graphics.setColor(255, 255, 255)
		love.graphics.print(self.list[self.currentItem], self.x + (self.width / 2) - gameFont:getWidth(self.list[self.currentItem]) / 2, self.y)

		self.previous:draw()
		self.next:draw()

		love.graphics.pop()
	elseif self.t == "button" then
		love.graphics.print(self.title, self.x, self.y)
	end
end

function gui:keypressed(key)
	if self.t == "list" then
		if key == "rbutton" then
			self.currentItem = math.min(self.currentItem + 1, #self.list)
		elseif key == "lbutton" then
			self.currentItem = math.max(self.currentItem - 1, 1)
		end
	end
end

function gui:mousepressed(x, y)

end

function gui:getValue()
	if self.t == "list" then
		return self.list[self.currentItem]
	end
end