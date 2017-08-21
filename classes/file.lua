file = class("file")

function file:init(y, i)
	self.x = 160 - 96
	self.y = y
	self.width = 192
	self.height = 48

	self.i = i
	
	self.data = saveManager:getSaveData(i)
	
	self.hearti = 1
end

function file:update(dt)

end

function file:draw()
	love.graphics.setScreen("bottom")

	if #self.data == 0 then
		love.graphics.setFont(menuFont)
		
		love.graphics.print("NEW FILE", self.x + (self.width / 2) - menuFont:getWidth("NEW FILE") / 2, (self.y + (self.height / 2)) - menuFont:getHeight() / 2 + 4)
	else
		love.graphics.setFont(smallFont)
		
		love.graphics.print("FILE " .. self.i, self.x + (self.width / 2) - smallFont:getWidth("FILE " .. self.i) / 2, self.y + 4)
		
		for x = 1, self.data[3] do
			local offset = 0
			if x % 2 == 0 then
				offset = 4
			end

			local i = 3
			if x > self.data[2] then
				i = 4
			end

			love.graphics.draw(healthImage, healthQuads[i], (self.x + 2) + (x - 1) * 9, (self.y + 15) + offset)
		end
	
		love.graphics.print(self.data[1]:gsub('"', ""), self.x, self.y + self.height - smallFont:getHeight())
		
		local ms = self:convertTime(self.data[4])
		love.graphics.print(ms, (self.x + self.width) - smallFont:getWidth(ms), (self.y + self.height) - smallFont:getHeight())
	end
end

function file:convertTime(seconds)
	local floor = math.floor
	
	local minutes = floor(seconds / 60)
	minutes = floor(minutes % 60)
	
	local hours = floor(minutes / 60)

	return string.format("%02d:%02d", hours, minutes)
end

function file:delete()
	saveManager:deleteData(self.i)
	self.data = saveManager:getSaveData(self.i)
end

function file:click(x, y)
	local pass = false

	if x and y then
		if aabb(x, y, 2, 2, self.x, self.y, self.width, self.height) then
			pass = true
		end
	else
		pass = true
	end

	if pass then
		local room = "indoors"
		if #self.data == 0 then --fresh file
			saveManager:save(self.i, {os.date("%m.%d.%Y"), 3, 3, 0, room, SPAWN_X, SPAWN_Y, 1, circlePadEnabled})
			currentScript = 1
		else
			saveManager:select(self.i)
			room = saveManager:getMap()
			circlePadEnabled = self.data[9]
		end
		util.changeState("game", room)
	end
end

function file:inside(x, y)
	return aabb(x, y, 2, 2, self.x, self.y, self.width, self.height) 
end