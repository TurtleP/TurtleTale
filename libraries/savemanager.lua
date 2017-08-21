local SGM = {}

function SGM:init()
	self.files = {}

	local exists = love.filesystem.isFile("save.txt")
	if exists then
		local data = love.filesystem.read("save.txt")

		if data then
			self.files = json:decode(data)
		else
			self:generateDefaultFiles()
		end
	else
		self:generateDefaultFiles()
	end
end

function SGM:generateDefaultFiles()
	for i = 1, 3 do
		self.files[i] = {}
	end
	self:save("all")
end

function SGM:select(i)
	self.currentSave = i

	SPAWN_X, SPAWN_Y = self.files[i][6], self.files[i][7]
	currentScript = self.files[i][8]
end

function SGM:getMap()
	return self.files[self:getCurrentSave()][5]
end

function SGM:generateSaveData() --hipsters..
	local date = os.date("%m.%d.%Y")
	if love.system.getModel() ~= "USA" then
		date = os.date("%d.%m.%Y")
	end

	local t =
	{
		date,
		objects["player"][1]:getHealth(),
		objects["player"][1]:getMaxHealth(),
		math.floor(self:getTime()),
		tiled:getMapName(),
		math.floor(objects["player"][1].x),
		math.floor(objects["player"][1].y),
		currentScript,
		circlePadEnabled
	}

	for k, v in pairs(objects["player"][1].abilities) do
		table.insert(t, {k, v}) 
	end

	return t
end

function SGM:deleteData(i)
	self:save(i, {})
end

function SGM:save(t, toSave)
	if t ~= "all" then
		self.files[t] = toSave
		savingData = true
	end

	str_data = json:encode_pretty(self.files)

	love.filesystem.write("save.txt", str_data)
end

function SGM:tick(dt)
	local i = self:getCurrentSave()

	self.files[i][4] = self.files[i][4] + dt
end

function SGM:getTime()
	return self.files[self:getCurrentSave()][4]
end

function SGM:getSaveData(i)
	local j = i
	if not j then
		j = self.currentSave or 1
	end

	return self.files[j]
end

function SGM:getCurrentSave()
	if not self.currentSave then
		return 1
	end

	return self.currentSave
end

return SGM