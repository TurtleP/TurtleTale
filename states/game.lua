local game = class("game")

function game:initialize(map)
	self.player = player:new(unpack(PLAYERSPAWN))
	self.display = hud:new(self.player)

	love.graphics.setBackgroundColor(BACKGROUNDCOLORS.sky)

	self.camera = vector(0, 0)
end

function game:load(map, fade, fadeSpeed)
	self.layers = {}

	self.layers[0] = {} --barriers?
	for i = 1, 4 do
		self.layers[i] = {}
	end

	self.dialogs = {}

	self.player:setPosition(unpack(PLAYERSPAWN))
	table.insert(self.layers[3], self.player)
	
	self.map = level:new(self.layers, map, fade, fadeSpeed)

	physics_load(self.layers)

	self.shakeValue = 0

	for k, v in pairs(CUTSCENES) do
		if not v[1].manual and not v[2] then
			event:load(k, v[1])
		end
	end

	if self.map:hasMusic() then
		if self.music then
			self.music:stop()
			self.music = nil
		end

		self.music = self.map.music
		self.music:setLooping(true)

		if not event:isRunning() and not self.music:isPlaying() then
			self.music:play()
		end
	end

	if MAP_DATA[self.map.name] then
		for i, v in pairs(self.layers) do
			for j, w in pairs(v) do
				for s, t in pairs(MAP_DATA[self.map.name]) do
					if t[1] == w.x and t[2] == w.y then
						w:fix()
					end
				end
			end
		end
	end
end

function game:addFixData(object, isSaved)
	local x, y = object.x, object.y
	if not isSaved then
		x, y = object.originX, object.originY
	end

	if not MAP_DATA[self.map.name] then
		MAP_DATA[self.map.name] = {}
	end

	table.insert(MAP_DATA[self.map.name], {x, y, isSaved})
end

function game:shake(value)
	self.shakeValue = value
end

function game:updateCamera()
	local MAP_WIDTH = self.map.width

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
end

function game:update(dt)
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
		self.shakeValue = math.max(self.shakeValue - 10 * dt, 0)
	end

	event:update(dt)

	save:update(dt)

	physicsupdate(dt)
end

function game:draw()
	love.graphics.setScreen("top")

	love.graphics.push()
	
	love.graphics.translate(self.shakeValue * math.random(-0.5, 0.5), 0)

	love.graphics.translate(-math.floor(self.camera.x), self.camera.y)

	self.map:draw()

	for i, v in ipairs(self.layers) do
		for j, w in ipairs(v) do
			if w.active and w.draw then
				w:draw()
			end
		end
	end

	love.graphics.pop()

	self.display:draw(self.map.offset)

	self.map:drawTransition()

	for i, v in ipairs(self.dialogs) do
		v:draw(self.map.offset)
	end

	save:draw()

	love.graphics.setScreen("bottom")
	love.graphics.draw(bottomScreenImage)
end

function game:keypressed(key)
	if not event:isRunning() then
		if key == CONTROLS["use"] then
			self.player:use(true)
		end
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
		self.player:duck(true)
	elseif key == CONTROLS["punch"] then
		self.player:punch(true)
	end
end

function game:keyreleased(key)
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
		self.player:duck(false)
	elseif key == CONTROLS["punch"] then
		self.player:punch(false)
	end
end

function game:destroy()
	if self.music then
		if not self.music:isPlaying() then
			self.music = nil
		end
	end
end

return game