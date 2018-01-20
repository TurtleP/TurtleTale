local save = class("save")

local file = require 'classes.file'

function save:initialize()
	self.data = {}
	self.files = {}

	self.currentSave = 1

	if self:hasData() then
		local data = love.filesystem.read("save.txt")

		if type(data) == "string" then
			self.data = json:decode(data)
		end
	else
		self:generateDefaultData()
	end

	self:loadData()
end

function save:hasData()
	return love.filesystem.isFile("save.txt") and true
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

function save:generateDefaultData()
	for i = 1, 3 do
		self.data[i] = {}
	end
	self:writeData("all")
end

function save:encode(i) --on save
	if not i then
		i = self.currentSave
	end

	local values = 
	{
		"money", "health", "maxhealth", 
		"x", "y", "scale", "abilities",
	}

	local data = { ["player"] = {}, ["achievements"] = {}, ["mapdata"] = {} }

	local player = state:get("player")

	for k, v in pairs(player) do
		for j, w in ipairs(values) do
			if k == w then
				data["player"][k] = v
			end
		end
	end

	local date = os.date("%m.%d.%Y")
	if love.system.getRegion() ~= "USA" then
		date = os.date("%d.%m.%Y")
	end
	data.date = date
	data.time = math.floor(self:getActiveFile().time)

	self:writeData(i, data)
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

function save:import()
	local player = state:get("player")
	for k, v in pairs(self:getActiveData()["player"]) do
		player[k] = v
	end
end

function save:loadData()
	for i = 1, 3 do
		self.files[i] = file:new(self.data[i])
	end
end

return save:new()