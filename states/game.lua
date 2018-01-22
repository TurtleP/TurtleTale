local game = class("game")

function game:initialize(map)
	self.player = player:new(unpack(PLAYERSPAWN))
	self.display = hud:new(self.player)

	love.graphics.setBackgroundColor(BACKGROUNDCOLORS.sky)

	self.camera = vector(0, 0)
end

function game:load(map, fade)
	if not map then
		map = "home"
	end

	self.layers = {}
	for i = 1, 4 do
		self.layers[i] = {}
	end

	self.player:setPosition(unpack(PLAYERSPAWN))
	table.insert(self.layers[3], self.player)
	
	self.map = level:new(self.layers, map, fade)

	physics_load(self.layers)
end

function game:updateCamera()
	local MAP_WIDTH = self.map.width

	if MAP_WIDTH > TOPSCREEN_WIDTH then
		if self.camera.x >= 0 and self.camera.x + TOPSCREEN_WIDTH <= MAP_WIDTH * 16 then
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

	physicsupdate(dt)
end

function game:draw()
	love.graphics.setScreen("top")

	love.graphics.push()
	love.graphics.translate(-self.camera.x, self.camera.y)

	self.map:draw()

	for i, v in ipairs(self.layers) do
		for j, w in ipairs(v) do
			w:draw()
		end
	end

	love.graphics.pop()

	self.display:draw()

	self.map:drawTransition()

	love.graphics.setScreen("bottom")
	love.graphics.draw(bottomScreenImage)
end

function game:keypressed(key)
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

return game