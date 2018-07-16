local game = class("game")

function game:initialize(map)
	self.player = player:new(unpack(PLAYERSPAWN))
	self.display = hud:new(self.player)

	love.graphics.setBackgroundColor(BACKGROUNDCOLORS.sky)

	self.camera = vector(0, 0)

	paused = false
end

function game:load(map, fade, fadeSpeed)
	self.layers = {}

	self.layers[0] = {} --barriers?
	for i = 1, 4 do
		self.layers[i] = {}
	end

	self.dialogs = {}

	self.player:unlock()
	self.player:setPosition(unpack(PLAYERSPAWN))
	table.insert(self.layers[3], self.player)
	
	self.map = level:new(self.layers, map, fade, fadeSpeed)

	physics_load(self.layers)

	self.shakeValue = 0

	for k, v in pairs(CUTSCENES) do
		if not v[1].manual and not v[2] then
			if v[1][1][1] == "levelequals" then
				if v[1][1][2] == map then
					event:load(k, v[1])
				end
			end
		end
	end

	if self.map:hasMusic() then
		if self.music and self.map.music then
			self.music:stop()
			self.music = nil
		end

		self.music = self.map.music
		self.music:setLooping(true)

		if not event:isRunning() and not self.music:isPlaying() then
			self.music:play()
		end
	end

	self:FixObjects()
end

function game:FixObjects(isGameover)
	if MAP_DATA[self.map.name] then
		for s, t in pairs(MAP_DATA[self.map.name]) do
			local object = self:findObject(t[1], t[2], t[3])
			
			if object and object.fix then
				object:fix()
			end
		end
	end
end

function game:addFixData(object, isSaved)
	local x, y = object.origin.x, object.origin.y

	if not MAP_DATA[self.map.name] then
		MAP_DATA[self.map.name] = {}
	end

	table.insert(MAP_DATA[self.map.name], {tostring(object), x, y, isSaved})
end

function game:addDialog(speaker, text, autoscroll)
	if #self.dialogs == 1 then
		return
	end
	table.insert(self.dialogs, dialog:new(speaker, text, autoscroll))
end

function game:shake(value)
	self.shakeValue = value
end

function game:updateCamera()
	local MAP_WIDTH = self.map.width
	local MAP_HEIGHT = self.map.height

	if MAP_WIDTH > TOPSCREEN_WIDTH then
		if self.camera.x >= 0 and self.camera.x + TOPSCREEN_WIDTH <= MAP_WIDTH then
			if self.player.x > self.camera.x + TOPSCREEN_WIDTH * 1 / 2 then
				self.camera.x = self.player.x - TOPSCREEN_WIDTH * 1 / 2
			elseif self.player.x < self.camera.x + TOPSCREEN_WIDTH * 1 / 2 then
				self.camera.x = self.player.x - TOPSCREEN_WIDTH * 1 / 2
			end
		end

		if self.camera.x < 0 then
			self.camera.x = 0
		elseif self.camera.x + TOPSCREEN_WIDTH >= MAP_WIDTH then
			self.camera.x = MAP_WIDTH - TOPSCREEN_WIDTH
		end
	end

	if MAP_HEIGHT > SCREEN_HEIGHT then
		if self.camera.y >= 0 and self.camera.y + SCREEN_HEIGHT <= MAP_HEIGHT then
			if self.player.y > self.camera.y + SCREEN_HEIGHT * 1 / 2 then
				self.camera.y = self.player.y - SCREEN_HEIGHT * 1 / 2
			elseif self.player.y < self.camera.y + SCREEN_HEIGHT * 1 / 2 then
				self.camera.y = self.player.y - SCREEN_HEIGHT * 1 / 2
			end
		end

		if self.camera.y < 0 then
			self.camera.y = 0
		elseif self.camera.y + SCREEN_HEIGHT >= MAP_HEIGHT then
			self.camera.y = MAP_HEIGHT - SCREEN_HEIGHT
		end
	end
end

function game:update(dt)
	if paused or SELECTING_SHELL then
		if SELECTING_SHELL then
			self.player.inventory:update(dt)
		end
		return
	end

	save:getActiveFile():tick(dt)

	self:updateCamera()

	self.display:update(dt)

	self.map:update(dt)
	self.map:checkChangeBounds(self)

	for i, v in ipairs(self.dialogs) do
		v:update(dt)
		if v.remove then
			table.remove(self.dialogs, i)
		end
	end

	if self.shakeValue > 0 then
		self.shakeValue = math.max(self.shakeValue - dt / 0.3, 0)
	end

	event:update(dt)

	save:update(dt)

	shop:update(dt)

	physicsupdate(dt)
end

function game:scissor(enable)
	if self.map.width < TOPSCREEN_WIDTH then
		if enable then
			love.graphics.setScissor(self.map.offset, 0, self.map.width, self.map.height)
		else
			love.graphics.setScissor()
		end
	end
end

function game:draw()
	love.graphics.setScreen("top")

	love.graphics.setColor(255, 255, 255, 255)

	if self.map.width < TOPSCREEN_WIDTH then
		love.graphics.setScissor(self.map.offset, 0, self.map.width, self.map.height)
	end

	self.map:drawBackground()

	love.graphics.push()
	
	if self.shakeValue > 0 then
		love.graphics.translate(self.shakeValue * math.random(-1.5, 1.5), 0)
	end

	love.graphics.translate(-math.floor(self.camera.x), -math.floor(self.camera.y))

	self.map:draw()

	for i, v in ipairs(self.layers) do
		for j, w in ipairs(v) do
			if w.active and w.draw then
				self:scissor(true)

				w:draw()

				self:scissor()
			end
		end
	end

	love.graphics.pop()

	self.display:draw(self.map.offset)

	self.map:drawTransition()

	love.graphics.setColor(255, 255, 255, 255)

	for i, v in ipairs(self.dialogs) do
		v:draw(self.map.offset)
	end

	save:draw()

	if SELECTING_SHELL then
		love.graphics.setColor(0, 0, 0, 180)
		love.graphics.rectangle("fill", 0, 0, TOPSCREEN_WIDTH, SCREEN_HEIGHT)
		love.graphics.setColor(255, 255, 255, 255)
	end
	
	if self.map.width < TOPSCREEN_WIDTH then
		love.graphics.setScissor()
	end

	love.graphics.setScreen("bottom")
	
	self:drawBottomScreen()
end

function game:drawBottomScreen()
	love.graphics.draw(bottomScreenImage)

	local _, battery = love.system.getPowerInfo()
	love.graphics.draw(batteryImage, 2, 2)
	love.graphics.rectangle("fill", 4, 4, (battery / 100) * 13, 5)

	love.graphics.draw(moneyImage, moneyQuads[3], BOTSCREEN_WIDTH - gameFont:getWidth(self.player.money) - 17, 4)
	love.graphics.print(self.player.money, BOTSCREEN_WIDTH - gameFont:getWidth(self.player.money) - 2, 2)

	if SHOP_OPEN then
		shop:draw()
	else
		self.player.inventory:draw()
	end
end

function game:keypressed(key)
	if self.map.changeMap then
		return
	end

	if not event:isRunning() then
		if key == CONTROLS["use"] then
			self.player:use(true)
		end
	end

	if not event:isRunning() and not SELECTING_SHELL and not paused then
		if key == "select" then
			SELECTING_SHELL = true
		end
	end

	if SELECTING_SHELL then
		self.player.inventory:keypressed(key)
	end

	if key == CONTROLS["pause"] then
		if not event:isRunning() then
			paused = not paused
			return
		end
	else
		if paused or SELECTING_SHELL then
			return
		end
	end

	if SHOP_OPEN then
		shop:keypressed(key)
	end

	for k, v in ipairs(self.dialogs) do
		v:keypressed(key)
	end
	
	if self.player.freeze then
		return
	end

	self.display:keypressed(key)

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

function game:keyreleased(key)
	if key == CONTROLS["use"] then
		self.player:use(false)
	end

	if key == "select" then
		if SELECTING_SHELL then
			self.player.inventory:keyreleased()
			SELECTING_SHELL = false
		end
	end

	if paused or SELECTING_SHELL then
		return
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

function game:mousepressed(x, y, button)
	if button == 1 then
		self.player.inventory:mousepressed(x, y)
	end
end

function game:destroy()
	if self.music then
		if not self.music:isPlaying() then
			self.music = nil
		end
	end
end

function game:findObject(name, x, y)
	local objects = self.layers

	for k, v in pairs(objects) do
		for j, w in pairs(v) do
			local check = tostring(w)

			if x and y and w.origin then
				if name and check == name then
					print(x, y, w.origin.x, w.origin.y)
					if w.origin.x == x and w.origin.y == y then
						return w
					end
				end
			else
				if check == name then
					return w
				end
			end
		end
	end

	return nil
end

return game