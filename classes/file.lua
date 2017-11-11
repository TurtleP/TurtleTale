file = class("file")

function file:init(y, i)
	self.x = 64
	self.y = y
	self.width = 192
	self.height = 48

	self.i = i
	
	self.data = saveManager:getSaveData(i)
	
	self.isNew = (self.data.date == nil)
	self.hearti = 1

	self.selected = false
end

function file:draw()
	love.graphics.setScreen("bottom")

	love.graphics.setFont(gameFont)
	if self.isNew then
		love.graphics.print("NEW FILE", self.x + (self.width / 2) - gameFont:getWidth("NEW FILE") / 2, (self.y + (self.height / 2)) - gameFont:getHeight() / 2)
	else
		love.graphics.print("FILE " .. self.i, self.x + (self.width / 2) - gameFont:getWidth("FILE " .. self.i) / 2, self.y)
		
		for x = 1, self.data.maxHealth do
			local offset = 0
			if x % 2 == 0 then
				offset = 4
			end

			local i = 3
			if x > self.data.health then
				i = 4
			end

			love.graphics.draw(healthImage, healthQuads[i], (self.x + 2) + (x - 1) * 9, (self.y + 15) + offset)
		end

		love.graphics.draw(shellImage, shellQuads[3], self.x + self.width - shellImage:getWidth(), self.y + 18)
		love.graphics.print(self.data.money, self.x + self.width - shellImage:getWidth() - gameFont:getWidth(self.data.money) - 4, self.y + 15)

		love.graphics.print(self.data.date, self.x, self.y + self.height - gameFont:getHeight())
		
		local ms = util.convertTime(self.data.playtime)
		love.graphics.print(ms, (self.x + self.width) - gameFont:getWidth(ms), (self.y + self.height) - gameFont:getHeight())
	end
end

function file:delete()
	saveManager:deleteData(self.i)
	self.data = saveManager:getSaveData(self.i)
	self:init(self.y, self.i)
end

function file:isSelected()
	return self.selected
end

function file:click(x, y)
	local room = "indoors"

	if self.isNew then --fresh file
		LOAD_EVENTS()
		saveManager:save(self.i, saveManager:generateSaveData())
		self.isNew = false
	else
		saveManager:select(self.i)
		room = saveManager:getMap()
		circlePadEnabled = self.data.circlePad
	end

	for k, v in pairs(MAP_DATA) do
		for j, w in ipairs(v) do
			if not w[3] then
				MAP_DATA[k] = nil
			end
		end
	end

	util.changeState("game", room)
end

function file:inside(x, y)
	return aabb(x, y, 2, 2, self.x, self.y, self.width, self.height) 
end