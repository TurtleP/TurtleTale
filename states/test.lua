local test = class("test")

function test:load()
	self.layers = {}
	for i = 0, 4 do
		self.layers[i] = {}
	end

	self.player = state.states["game"].player
	self.player:setPosition(200, 210)
	table.insert(self.layers[3], self.player)

	self.map = level:new(self.layers, "test")
	self.dialogs = {}

	self.objects =
	{
		{"player", {}},
		{"hermit", { evil = true }},
		{"health", {}},
		{"bat", {}},
		{"spider", {}},
	}

	physics_load(self.layers)

	self.currentObject =1
end

function test:update(dt)
	physicsupdate(dt)

	state.states["game"].display:update(dt)
end

function test:draw()
	love.graphics.setScreen("top")

	self.map:draw()

	state.states["game"].display:draw(0)

	love.graphics.rectangle("fill", (math.floor(love.mouse.getX() / 16) * 16) + 40, math.max(0, math.min(math.floor(love.mouse.getY() / 16) * 16, SCREEN_HEIGHT - 16)) , 16, 16)

	for i, v in ipairs(self.layers) do
		for j, w in ipairs(v) do
			if w.active and w.draw then
				w:draw()
			end
		end
	end

	love.graphics.setScreen("bottom")
	love.graphics.print("Object: " .. self.objects[self.currentObject][1])
	love.graphics.print("Properties:", 0, 11)
	
	local i = 0
	for k, v in pairs(self.objects[self.currentObject][2]) do
		if type(k) == "string" then
			love.graphics.print(k .. ": " .. tostring(v), 0, 22 + i * 11)
		end
		i = i + 1
	end
end

function test:keypressed(key)
	if key == CONTROLS["use"] then
		self.player:use(true)
	end
	
	for k, v in ipairs(self.dialogs) do
		v:keypressed(key)
	end

	if self.player.freeze then
		return
	end

	if key == CONTROLS["jump"] then
		self.player:jump()
	elseif key == CONTROLS["right"] then
		self.player:moveRight(true)
	elseif key == CONTROLS["left"] then
		self.player:moveLeft(true)
	elseif key == CONTROLS["duck"] then
		self.player:moveDown(true)
		if not self.player:checkLadder() then
			self.player:duck(true)
		end
	elseif key == CONTROLS["punch"] then
		self.player:punch(true)
	end
end

function test:keyreleased(key)
	if key == CONTROLS["use"] then
		self.player:use(false)
	end

	if self.player.freeze then
		return
	end

	if key == CONTROLS["right"] then
		self.player:moveRight(false)
	elseif key == CONTROLS["left"] then
		self.player:moveLeft(false)
	elseif key == CONTROLS["duck"] then
		self.player:moveDown(false)
		if not self.player.onLadder then
			self.player:duck(false)
		end
	elseif key == CONTROLS["punch"] then
		self.player:punch(false)
	end
end

function test:mousepressed(x, y, button)
	if button == 1 then
		if self.currentObject == 1 then -- player
			self.player:setPosition(x, y)
		else
			local data = self.objects[self.currentObject]
			self.map:createEntity(data[1], x, y, data[2])
		end
	end
end

function test:wheelmoved(x, y)
	self.currentObject = math.max(1, math.min(self.currentObject + y, #self.objects))
end

function test:destroy()
	self.layers = nil
	self.map = nil
end

return test