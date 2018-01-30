local save = class("save")

local file = require 'classes.file'

local bookImage = love.graphics.newImage("graphics/game/hud/savegame.png")
local bookQuads = {}
for i = 1, 10 do
	bookQuads[i] = love.graphics.newQuad((i - 1) * 32, 0, 32, 32, bookImage:getWidth(), bookImage:getHeight())
end

function save:initialize()
	self.data = {}
	self.files = {}

	self.currentSave = 1

	if self:hasData() then
		self:loadData()
	else
		self:generateDefaultData()
	end

	self:loadFiles()
end

function save:hasData()
	return love.filesystem.isFile("save.txt")
end

function save:getData(i)
	return self.data[i]
end

function save:getActiveData()
	return self.data[self.currentSave]
end

function save:getActiveFile()
	return self.files[self.currentSave]
end

function save:getFiles()
	return self.files
end

function save:get(var)
	if self.data[self.currentSave][var] then
		return self.data[self.currentSave][var]
	end
end

function save:generateDefaultData()
	for i = 1, 3 do
		self.data[i] = {}
	end
	self:writeData("all")
end

function save:encode(i, t) --on save
	if not i then
		i = self.currentSave
	end

	if t == "achievements" and self.data[i]["achievements"] then --already in-game so ..
		for k, v in pairs(achievements["achievements"]) do
			self.data[i]["achievements"][k] = v.unlocked
		end
		self:writeData(i, self.data[i])
		return
	end

	local values = 
	{
		{"money", 0}, {"health", 3}, {"maxHealth", 3},
		{"x", 0}, {"y", 0}, {"scale", 1}, {"abilities", {}}
	}

	local map = "indoors"
	if state:get("map") then
		map = state:get("map").name
	end

	local data = 
	{ 
		["cutscenes"] = {},
		["player"] = {},
		["achievements"] = {},
		["mapdata"] = MAP_DATA,
		["map"] = map,
		["shopdata"] = SHOP_DATA,
		["inventory"] = state:get("display").inventory
	}

	local player = state:get("player")

	if player then
		for k, v in pairs(player) do
			for j, w in ipairs(values) do
				if k == w[1] then
					if type(v) == "number" then
						v = math.floor(v)
					end

					data["player"][k] = v
				end
			end
		end
	else
		for j, w in ipairs(values) do
			data["player"][w[1]] = w[2]
		end
	end

	for k, v in pairs(CUTSCENES) do
		if not v[1].manual then
			data["cutscenes"][k] = v[2]
		end
	end

	local date = os.date("%m.%d.%Y")
	if love.system.getRegion() ~= "USA" then
		date = os.date("%d.%m.%Y")
	end
	data.date = date
	data.time = math.floor(self:getActiveFile().time)

	self:writeData(i, data)

	self.fade = 1
	self.timer = 0
	self.quadi = 1
	self.saving = true
end

function save:update(dt)
	if self.saving then
		self.timer = self.timer + 10 * dt
		if self.quadi < #bookQuads then
			self.quadi = math.floor(self.timer % #bookQuads) + 1
		else
			self.fade = math.max(self.fade - dt, 0)

			if self.fade == 0 then
				self.saving = false
			end
		end
	end
end

function save:draw()
	if not self.saving then
		return
	end

	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.draw(bookImage, bookQuads[self.quadi], TOPSCREEN_WIDTH - 34, SCREEN_HEIGHT - 34)
	love.graphics.setColor(255, 255, 255, 255)
end

function save:writeData(file, data)
	if file ~= "all" then
		if not file then
			file = self.currentSave
		end

		self.data[file] = data

		self.currentSave = file
	end

	love.filesystem.write("save.txt", json:encode_pretty(self.data))
end

function save:import(t)
	if t == "player" then
		local player = state:get("player")
		for k, v in pairs(self:getActiveData()["player"]) do
			player[k] = v
		end

		local display = state:get("display")
		display.inventory = self:getActiveData()["inventory"]

		PLAYERSPAWN = {player.x, player.y}
	else
		for j, w in pairs(self:getActiveData()["cutscenes"]) do
			CUTSCENES[j][2] = w
		end

		if self:getActiveData()["shopdata"] then
			SHOP_DATA = self:getActiveData()["shopdata"]
		end

		if self:getActiveData()["mapdata"] then
			MAP_DATA = self:getActiveData()["mapdata"]
		end

		if self:getActiveData()["achievements"] then
			for k, v in pairs(self:getActiveData()["achievements"]) do
				achievements:unlock(k, true)
			end
		end
	end
end

function save:loadData()
	local data = love.filesystem.read("save.txt")

	if type(data) == "string" then
		self.data = json:decode(data)
	end
end

function save:loadFiles(fileIndex)
	if fileIndex then
		self.files[fileIndex] = file:new(self.data[fileIndex], fileIndex)
		return self.files[fileIndex]
	end

	for i = 1, 3 do
		self.files[i] = file:new(self.data[i], i)
	end
end

return save:new()