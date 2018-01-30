hud = class("hud")

local inventoryBackImage = love.graphics.newImage("graphics/game/hud/inventory.png")

local inventoryIcons = love.graphics.newImage("graphics/game/hud/icons_new.png")
local inventoryIconQuads = {}
local itemNames = {"water", "rope", "wax", "bubble", "key"}
for i = 1, #itemNames do
	inventoryIconQuads[itemNames[i]] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, inventoryIcons:getWidth(), inventoryIcons:getHeight())
end


function hud:initialize(player)
	self.x = 2
	self.y = 2

	self.player = player
	self.timer = 0

	self.heartAnimation = {1, 2, 3, 2}

	self.inventory = {}
	self.item = 1
end

function hud:update(dt)
	self.timer = self.timer + 6.5 * dt
end

function hud:draw(offset)
	love.graphics.push()
	love.graphics.translate((offset or 0), 0)

	love.graphics.draw(inventoryBackImage, self.x, self.y)

	local name, count = self:getItemQuad()
	if name ~= nil then
		if count == 0 then
			love.graphics.setColor(180, 180, 180, 200)
		end
		love.graphics.draw(inventoryIcons, inventoryIconQuads[self:getItemQuad()], self.x, self.y)
	end

	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print("x", self.x + 15 - gameFont:getWidth("x"), self.y + 7)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("x", self.x + 16 - gameFont:getWidth("x"), self.y + 8)

	
	for i = 1, self.player.maxHealth do
		local quadi, add = 3, 0
		if i > self.player.health then
			quadi = 4
		elseif i == self.player.health then
			quadi = self.heartAnimation[math.floor(self.timer % #self.heartAnimation) + 1]
		end

		if i % 2 == 0 then
			add = 4
		end

		love.graphics.draw(healthImage, healthQuads[quadi], self.x + 18 + (i - 1) * 9, self.y + add)
	end

	love.graphics.pop()
end

function hud:keypressed(key)
	if key == "l" then
		self.item = self.item - 1
		if self.item < 1 then
			self.item = #self.inventory
		end
	elseif key == "r" then
		self.item = self.item + 1
		if self.item > #self.inventory then
			self.item = 1
		end
	elseif key == "x" then
		self:useItem()
	end
end

function hud:addToInventory(name, value)
	local index, count = self:getItemQuad(name)
	if not value then
		value = 1
	end

	if not index then
		table.insert(self.inventory, {name, count + 1})
	else
		self.inventory[index][2] = math.max(0, math.min(self.inventory[index][2] + value, 99))
	end
end

function hud:useItem(name, force)
	local count
	if not name then
		name, count = self:getItemQuad()
	end

	local player, map = state:get("player"), state:get("map")

	if count and count > 0 then
		if name == "water" or name =="auto" then
			if player.health < player.maxHealth then
				player:addHealth(2)
			end
		elseif name == "rope" then
			if not map.name:find("boss") then
				player.freeze = true
				player.scale = save:get("player").scale
				map:changeLevel(state.states["game"], save:get("map") .. ";" .. save:get("player").x .. ";" .. save:get("player").y)
			end
		end
		self:addToInventory(name, -1)
	end
end

function hud:getItemQuad(isName)
	for k, v in ipairs(self.inventory) do
		local name, count = v[1], v[2]

		if not isName then
			if k == self.item then
				return name, count
			end
		else
			if name == isName then
				return k, count
			end
		end
	end
	return nil, 0
end
