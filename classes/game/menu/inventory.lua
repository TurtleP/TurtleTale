local inventory = class("inventory")

local shellsImage = love.graphics.newImage("graphics/game/hud/shells.png")
local shellQuads = {}
for x = 1, shellsImage:getWidth() / 30 do
	table.insert(shellQuads, love.graphics.newQuad((x - 1) * 30, 0, 30, 21, shellsImage:getWidth(), shellsImage:getHeight()))
end

local shellCursor = love.graphics.newImage("graphics/game/hud/shell_cursor.png")
local cursorQuads = {}
for i = 1, 2 do
	cursorQuads[i] = love.graphics.newQuad((i - 1) * 30, 0, 30, 30, shellCursor:getWidth(), shellCursor:getHeight())
end

function inventory:initialize()
	self.items = 
	{
		{x = 156, y = 122, r = 20, quadi = 2, unlocked = true, on = function() end, off = function() end},
		{x = 156, y = 72,  r = 20, quadi = 3, unlocked = true, on = function(player)
			player:addMaxHealth()
		end, off = function(player) player:setHealth(player.maxHealth - 1) end},
		{x = 197, y = 99,  r = 20, quadi = 4, unlocked = false},
		{x = 197, y = 147, r = 20, quadi = 5, unlocked = false},
		{x = 156, y = 177, r = 20, quadi = 6, unlocked = false},
		{x = 115, y = 147, r = 20, quadi = 7, unlocked = false},
		{x = 115, y = 99,  r = 20, quadi = 8, unlocked = false},
	}

	self.cursor = vector(self.items[1].x - 15, self.items[1].y - 15)
	self.cursori = 1
	self.cursorTimer = 0
	self.selection = 1
end

function inventory:update(dt)
	self.cursorTimer = self.cursorTimer + 2 * dt
	self.cursori = math.floor(self.cursorTimer % 2) + 1
end

function inventory:draw(offset)
	if not SELECTING_SHELL then
		love.graphics.setColor(255, 255, 255, 150)
	else
		love.graphics.setColor(255, 255, 255, 255)

		love.graphics.draw(shellCursor, cursorQuads[self.cursori], self.cursor.x, self.cursor.y)
	end

	for i = 1, #self.items do
		local v = self.items[i]

		if v.unlocked then
			love.graphics.draw(shellsImage, shellQuads[v.quadi], v.x - 15, v.y - 10)
		else
			love.graphics.draw(shellsImage, shellQuads[1], v.x - 15, v.y - 10)
		end
	end
end

function inventory:mousepressed(x, y)
	local item
	for i = 1, #self.items do
		if math.abs(distance(x, y, self.items[i].x, self.items[i].y)) < self.items[i].r then
			item = i
			break
		end
	end

	if not item then
		return
	end

	self:wearShell(item)
end

function inventory:activateShell(player)
	print("saaaave", player.graphic)
	self.items[player.graphic].on(player)
end

function inventory:keypressed(key)
	local i, isDown = 1, love.keyboard.isDown
	if key == "up" then
		if isDown("right") then
			i = 3
		elseif isDown("left") then
			i = #self.items
		elseif not isDown("left") and not isDown("right") then
			i = 2
		end
	elseif key == "down" then
		if isDown("right") then
			i = 4
		elseif isDown("left") then
			i = 6
		elseif not isDown("left") and not isDown("right") then
			i = 5
		end
	end

	self.selection = i
	self.cursor = vector(self.items[i].x - 15, self.items[i].y - 15)
end

function inventory:keyreleased(key)
	self:wearShell(self.selection)
end

function inventory:wearShell(i)
	if self.items[i].unlocked then
		local player = state:get("player")
		if player.graphic ~= i then
			self.items[player.graphic].off(player)

			player.graphic = i

			self.items[player.graphic].on(player)
		end
	end
end

return inventory