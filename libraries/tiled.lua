local tiled = {}

function tiled:init()
	self.mapWidth = {["top"] = 0, ["bottom"] = 0}
	self.mapHeight = 15

	self.objects = {}
	self.background = nil
	self.tiles = nil
	self.offset = 0
end

function tiled:loadMap(path)
	self:init()

	self.map = require(path)

	self:loadData("top")
	self:loadData("bottom")
end

function tiled:cacheMaps()
	self:init()

	self.maps = {}
	
	local items = love.filesystem.getDirectoryItems("data/maps")

	for k, v in ipairs(items) do
		if v:sub(-4) == ".lua" then
			local name = v:gsub(".lua", "")
			self.maps[name] = require("data.maps." .. name)
		end
	end
end

function tiled:setMap(map)
	self:init()

	self.map = self.maps[map]

	self.currentMap = map
	
	self:loadData("top")

	if self.map.properties.song then
		if self.songName and self.songName ~= self.map.properties.song then
			if self.song then
				self.song:stop()
				self.song = nil

				collectgarbage()
				collectgarbage()
			end
		end

		if not self.song then
			self.song = love.audio.newSource("audio/music/" .. self.map.properties.song .. ".ogg", "stream")
			self.song:setLooping(true)
			self.songName = self.map.properties.song
		end
	end

	local background
	if self.map.properties.background then
		self.background = nil

		collectgarbage()
		collectgarbage()

		background = love.graphics.newImage("graphics/backgrounds/" .. self.map.properties.background .. ".png")
	else
		background = love.graphics.newImage("graphics/backgrounds/sky.png")
	end
	self.background = background

	self.offset = self.map.properties.offset or 0
	mapScroll = -self.offset

	if self.offset ~= 0 then
		love.graphics.setBackgroundColor(0, 0, 0)
	end
end

function tiled:loadData(screen)
	local mapData, entityData = self.map.layers, {}

	if screen == "top" then
		self.tiles = nil

		collectgarbage()
		collectgarbage()

		if love.filesystem.isFile("data/maps/" .. self.currentMap .. ".png") then
			self.tiles = love.graphics.newImage("data/maps/" .. self.currentMap .. ".png")
		end
	end

	self.mapWidth[screen] = self.map.width

	for k, v in ipairs(mapData) do
		if v.type == "tilelayer" then
			if v.name == screen .. "Tiles" then
				mapData = self.map.layers[k].data

				self.mapHeight = self.map.layers[k].properties.height
			end
		elseif v.type == "objectgroup" then
			if v.name == screen .. "Objects" then
				entityData = self.map.layers[k].objects
			end
		end
	end

	for k, v in ipairs(entityData) do
		if not self.objects[v.name] then
			self.objects[v.name] = {}
		end

		if _G[v.name] then
			if v.name == "tile" then
				table.insert(self.objects["tile"], tile:new(v.x, v.y, v.width, v.height, v.properties))
			else
				if v.name == "trigger" then
					table.insert(self.objects[v.name], _G[v.name]:new(v.x, v.y, v.width, v.height, v.properties, screen))
				else
					table.insert(self.objects[v.name], _G[v.name]:new(v.x, v.y, v.properties, screen))
				end
			end
		else
			error("Failed to load " .. v.name .. "! Did you forget to require its file?")
		end
	end
end

function tiled:playCurrentSong()
	if self.song then
		if not self.song:isPlaying() then
			self.song:play()
		end
	end
end

function tiled:getCurrentSong()
	return self.song
end

function tiled:clearCache()
	self:init()

	if self.song then
		self.song:stop()
		self.song = nil
	end
	
	collectgarbage()
	collectgarbage()
end

function tiled:getOffset()
	return self.offset
end

function tiled:getNextMap(dir)
	if not self.objects["trigger"] then
		return false
	end

	for i = 1, #self.objects["trigger"] do
		local v = self.objects["trigger"][i]

		if dir == "left" and v.x == 0 then
			return true
		elseif dir == "right" and v.x == self:getWidth("top") * 16 then
			return true
		end 
	end

	return false
end

function tiled:renderBackground()
	if self.background then
		if state ~= "title" then
			for x = 1, math.ceil((self.map.width * 16) / self.background:getWidth()) do
				love.graphics.draw(self.background, (x - 1) * 400, 0)
			end
		end
	end

	if self.tiles then
		love.graphics.draw(self.tiles, 0, 0)
	end
end

function tiled:getBackgroundColor()
	return backgroundColors[backgroundColori[player.screen]]
end

function tiled:changeSong(screen)
	local otherScreen = "top"
	if screen == "top" then
		otherScreen = "bottom"
	end
	_G[self.music[otherScreen] .. "Song"]:stop()
	playSound(_G[self.music[screen] .. "Song"])
end

function tiled:getWidth(screen)
	return self.mapWidth["top"]
end

function tiled:getTiles()
	return self.objects["tile"]
end

function tiled:getObjects(name)
	if type(name) == "table" then
		local ret = {}

		for i = 1, #name do
			if self.objects[name[i]] then
				table.insert(ret, self.objects[name[i]])
			end
		end

		return ret
	else
		return self.objects[name] or {}
	end
end

function tiled:getMapName()
	return self.currentMap
end

return tiled