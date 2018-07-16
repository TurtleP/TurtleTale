door = class("door", object)

local bossDoorImage = love.graphics.newImage("graphics/game/objects/door.png")
local bossDoorQuads = {}
for y = 1, 5 do
	for x = 1, 4 do
		table.insert(bossDoorQuads, love.graphics.newQuad((x - 1) * 32, (y - 1) * 32, 32, 32, bossDoorImage:getWidth(), bossDoorImage:getHeight()))
	end
end

function door:initialize(layer, x, y, width, height, properties)
	object.initialize(self, x, y, width, height)

	for k, v in pairs(properties) do
		if type(k) == "string" then
			print(k, v)
			self[k] = v
		end
	end

	local func = function(player)
		if self.active then
			local map = state:get("map")
			map:changeLevel(state.states["game"], self.link)
			player.speed = vector(0, 0)
			player.freeze = true
		end
	end

	local oldFunc = func
	if self.t == "boss" then
		self.quadi = 1
		self.timer = 0
		self.open = false

		func = function(player)
			local display = state:get("display")

			if not self.open then
				self.open = true
				display:addToInventory("key", -1)
			else
				oldFunc(player)
			end
		end

		self.offset = 0
	end

	self.useRectangle = userectangle:new(self.x, self.y, self.width, self.height, func, false, false)

	table.insert(layer, self)
end

function door:update(dt)
	self.useRectangle:update(dt)

	if self.t == "boss" then
		if self.open then
			self.timer = self.timer + 10 * dt
			if self.quadi == (#bossDoorQuads - 1) then
				self.offset = 13
				self.timer = 0
			end

			self.quadi = self.offset + math.floor(self.timer % (#bossDoorQuads - 1)) + 1
		end
	end
end

function door:draw()
	if self.t == "boss" then
		love.graphics.draw(bossDoorImage, bossDoorQuads[self.quadi], self.x, self.y)
		
		if not self.open then
			return
		end
	else
		if self.visible then
			love.graphics.draw(gameTilesImage, gameTilesQuads[186], self.x, self.y - self.height)
			love.graphics.draw(gameTilesImage, gameTilesQuads[208], self.x, self.y)
		end
	end
	self.useRectangle:draw()
end

function door:setVisible(isVisible)
	self.visible = isVisible
	self.active = isVisible
end