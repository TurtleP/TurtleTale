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

	SPAWN_X, SPAWN_Y = self.files[i].playerPosition[1], self.files[i].playerPosition[2]
	
	for k, v in pairs(self.files[i].mapData) do
		if k:find("shop") then
			SHOP_DATA[k] = v
		else
			for j = 1, #v do
				HIDDEN_ITEMS[k][j].used = v[j]
			end
		end
	end

	for k, v in pairs(self.files[i].cutscenes) do
		cutscenes[k][2] = v
	end

	GAME_EVENTS = self.files[i].events
	MAP_DATA = self.files[i].entities
end

function SGM:getMap()
	return self.files[self:getCurrentSave()].currentMap
end

function SGM:generateSaveData() --hipsters..
	local date = os.date("%m.%d.%Y")
	if love.system.getRegion() ~= "USA" then
		date = os.date("%d.%m.%Y")
	end

	local position, health, maxHealth, mapName, moneyAmount, direction, abilities, playerInventory, playerKey = {0, 0}, 3, 3, "indoors", 0, 1, {}, {}, nil
	if objects["player"] then
		position = {math.floor(objects["player"][1].x), math.floor(objects["player"][1].y)}
		health, maxHealth = objects["player"][1]:getHealth(), objects["player"][1]:getMaxHealth()
		mapName = tiled:getMapName()
		moneyAmount = objects["player"][1]:getMoney()
		direction = objects["player"][1].scale
		abilities = objects["player"][1].abilities
		playerInventory = objects["player"][1].inventory:getItems()
		playerKey = (objects["player"][1].key ~= nil)
	end

	local t =
	{
		date = date,
		health = health,
		maxHealth = maxHealth,
		playtime = math.floor(self:getTime()) or 0,
		currentMap = mapName,
		playerPosition = position,
		cutscenes = {},
		circlePad = circlePadEnabled,
		abilities = abilities,
		money = moneyAmount,
		mapData = {},
		direction = direction,
		entities = {},
		inventory = playerInventory,
		key = playerKey
	}

	for k, v in pairs(SHOP_DATA) do
		t.mapData[k] = v
	end

	for k, v in pairs(cutscenes) do
		if not v[1].manual then
			t.cutscenes[k] = v[2]
		end
	end

	for k, v in pairs(HIDDEN_ITEMS) do
		t.mapData[k] = {}
		table.insert(t.mapData[k], v.used)
	end

	for k, v in pairs(MAP_DATA) do
		t.entities[k] = {}
		for j, w in ipairs(v) do
			if w[3] == true then
				table.insert(t.entities[k], w)
			end
		end
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

		if not self.currentSave then
			self.currentSave = t
		end
	end

	str_data = json:encode_pretty(self.files)

	love.filesystem.write("save.txt", str_data)
end

function SGM:tick(dt)
	local i = self:getCurrentSave()

	if not self.files[i].playtime then
		return
	end
	self.files[i].playtime = self.files[i].playtime + dt
end

function SGM:getTime()
	return self.files[self:getCurrentSave()].playtime or 0
end

function SGM:getSaveData(i)
	local j = i
	if not j then
		j = self.currentSave or 1
	end

	return self.files[j]
end

function SGM:getShopData(shop)

end

function SGM:getCurrentSave()
	if not self.currentSave then
		return 1
	end

	return self.currentSave
end

return SGM