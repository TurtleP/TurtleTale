enemyspawner = class("enemyspawner")

function enemyspawner:init(x, y, properties)
	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.active = true
	self.static = true

	self.enemies = {}

	self.delay = 1

	local spawnType = ""
	if properties.spawn ~= nil then
		spawnType = properties.spawn
	end
	self.spawn = spawnType

	local maxEnemies = 0
	if properties.enemies ~= nil then
		maxEnemies = properties.enemies
	end
	self.maxEnemies = maxEnemies
	self.enemyCount = 0
end

function enemyspawner:update(dt)
	
	if #self.enemies < 1 then
		self.delay = self.delay - dt

		if self.delay < 0 then
			local spawn = _G[self.spawn]:new(self.x, self.y)

			if self.spawn == "bat" then
				table.insert(objects["bat"], spawn)

				spawn:drop()
			end
			table.insert(self.enemies, spawn)

			local smokeSpawn = smoke:new((self.x + 8) - 12, (self.y + 8) - 12)
			smokeSpawn:setQuad(6)

			table.insert(prefabs, smokeSpawn)

			self.delay = 1
		end
	end

	for i = #self.enemies, 1, -1 do
		if self.enemies[i].remove then
			table.remove(self.enemies, i)
			self.enemyCount = self.enemyCount + 1
		end
	end

	if self.enemyCount == self.maxEnemies then
		self.remove = true
	end
end