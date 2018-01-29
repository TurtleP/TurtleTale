level = class("level")

level.SONGNAME = nil

function level:initialize(layers, name, fade, fadeSpeed)
	self.data = MAPS[name]
	self.name = name
	self.layers = layers

	self.width = self.data.width * 16
	self.height = self.data.height * 16

	for _, v in pairs(self.data.layers) do
		if v.type == "objectgroup" then
			self:createEntities(layers, v.objects)
		end
	end

	self.tiles = love.graphics.newImage("data/maps/" .. name .. ".png")

	local background = "sky"
	if self.data.properties.background then
		background = self.data.properties.background
	end
	self.background = love.graphics.newImage("graphics/backgrounds/" .. background .. ".png")

	if self.data.properties.song then
		if level.SONGNAME ~= self.data.properties.song then
			print("music: " .. tostring(level.SONGNAME))
			self.music = love.audio.newSource("audio/music/" .. self.data.properties.song .. ".ogg")
		end
	end

	if self:hasLink("next") then
		self.nextMap = self.data.properties.next:split(";")[1]
	else
		barrier:new(layers[0], self.width, 0, 1, SCREEN_HEIGHT)
	end
	
	if self:hasLink("prev") then
		self.previousMap = self.data.properties.prev:split(";")[1]
	else
		barrier:new(layers[0], -1, 0, 1, SCREEN_HEIGHT)
	end

	self.changeMap = false
	self.fade = fade or 0
	self.fadeSpeed = fadeSpeed or 0.5

	self.offset = (self.data.properties.offset or 0)
	local camera = state:get("camera")
	if camera then
		camera.x = -self.offset
	end

	shop:loadData(self.name)

	if self.offset ~= 0 then
		love.graphics.setBackgroundColor(0, 0, 0)
	else
		love.graphics.setBackgroundColor(BACKGROUNDCOLORS.sky)
	end
end

function level:getOffset()
	return self.offset
end

function level:createEntity(name, x, y, properties)
	local data = { { name = name, x = x, y = y, properties = properties or {} } }

	self:createEntities(self.layers, data)
end

function level:createEntities(layers, objects)
	for k, v in pairs(objects) do
		if _G[v.name] then
			if v.name == "tile" then
				tile:new(layers[2], v.x, v.y, v.width, v.height, v.properties)
			elseif v.name == "house" then
				house:new(layers[2], v.x, v.y)
			elseif v.name == "clock" then
				clock:new(layers[2], v.x, v.y)
			elseif v.name == "bed" then
				bed:new(layers[2], v.x, v.y, v.properties)
			elseif v.name == "water" then
				water:new(layers[4], v.x, v.y, v.width, v.height)
			elseif v.name == "door" then
				door:new(layers[0], v.x, v.y, v.properties)
			elseif v.name == "sign" then
				sign:new(layers[1], v.x, v.y, v.properties)
			elseif v.name == "palm" then
				palm:new(layers[2], v.x, v.y)
			elseif v.name == "hermit" then
				hermit:new(layers[2], v.x, v.y, v.properties)
			elseif v.name == "bat" then
				bat:new(layers[2], v.x, v.y)
			elseif v.name == "spider" then
				spider:new(layers[2], v.x, v.y)
			elseif v.name == "userectangle" then
				table.insert(layers[0], userectangle:new(v.x, v.y, v.width, v.height, require(v.properties.func), false))
			elseif v.name == "block" then
				block:new(layers[2], v.x, v.y, v.width, v.height, v.properties)
			elseif v.name == "button" then
				button:new(layers[2], v.x, v.y, v.properties)
			elseif v.name == "chest" then
				chest:new(layers[1], v.x, v.y, v.properties)
			elseif v.name == "health" then
				health:new(v.x, v.y)
			elseif v.name == "barrier" then
				barrier:new(layers[0], v.x, v.y, v.width, v.height)
			end
		else
			print(v.name .. " does not exist.")
		end
	end
end

function level:hasLink(link)
	return self.data.properties[link] ~= nil
end

function level:hasMusic()
	return self.music ~= nil
end

function level:checkChangeBounds(game)
	local player = game.player

	if self.fade == 0 and not self.changeMap then
		if self.previousMap then
			if player.x < 0 then
				self:changeLevel(game, "prev")
			end
		end

		if self.nextMap then
			if player.x + player.width > self.width then
				self:changeLevel(game, "next")
			end
		end
	end
end

function level:changeLevel(game, link)
	game.player.freeze = true
	
	if self.data.properties[link] then
		self.newLevel = self.data.properties[link]:split(";")
		
		local x = 2
		if link == "prev" then
			x = (MAPS[self.newLevel[1]].width * 16) - 2
		end
		PLAYERSPAWN = {x, tonumber(self.newLevel[3])}
		
		if link == "prev" then
			game.player:moveLeft(true)
		else
			game.player:moveRight(true)
		end
	else
		if self.fadeSpeed ~= 1 then
			self.fadeSpeed = 1
		end
		
		self.newLevel = link:split(";")
		PLAYERSPAWN = {tonumber(self.newLevel[2]), tonumber(self.newLevel[3])}
	end
	
	local song = MAPS[self.newLevel[1]].properties.song
	if (song ~= nil and song ~= level.SONGNAME) then
		level.SONGNAME = song
	end
	
	self.changeMap = true
end

function level:update(dt)
	if self.changeMap then
		self.fade = math.min(self.fade + self.fadeSpeed * dt, 1)
	else
		self.fade = math.max(self.fade - self.fadeSpeed * dt, 0)
	end

	--if self.newLevel then
	if self.changeMap then
		if self.fade == 1 and self.newLevel then
			state:change("game", self.newLevel[1], 1, 1)
		end
	else
		local player = state:get("player")

		if self.fade > 0.3 then
			if player.leftkey and player.x < self.width - 16 then
				player:moveLeft(false)
			elseif player.rightkey and player.x > 16 then
				player:moveRight(false)
			end

			if not event:isRunning() then
				player.freeze = false
			end
		end
	end
--	end
end

function level:draw()
	for x = 1, math.ceil(self.width / self.background:getWidth()) do
		love.graphics.draw(self.background, (x - 1) * TOPSCREEN_WIDTH, 0)
	end

	love.graphics.draw(self.tiles)
end

function level:drawTransition()
	love.graphics.setColor(0, 0, 0, 255 * self.fade)
	love.graphics.rectangle("fill", self.x, self.y, TOPSCREEN_WIDTH, SCREEN_HEIGHT)
	
	love.graphics.setColor(255, 255, 255, 255)
end