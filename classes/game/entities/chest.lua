chest = class("chest", object)

local chestImage = love.graphics.newImage("graphics/game/objects/chest.png")
local chestQuads = {}
for x = 1, 5 do
	chestQuads[x] = love.graphics.newQuad((x - 1) * 28, 0, 28, 19, chestImage:getWidth(), chestImage:getHeight())
end

function chest:initialize(layer, x, y, properties)
	object.initialize(self, x, y, 28, 19)

	self.gravity = 480
	self.quadi = 1

	self.timer = 0

	self.open = false
	self.visible = true
	self.static = false

	self.mask = { true }

	for k, v in pairs(properties) do
		if type(k) == "string" then
			self[k] = v
		end
	end

	self.useRectangle = userectangle:new(self.x + (16 - 28) / 2, self.y, self.width, self.height, function(player)
		if self.locked then
			local _, count = state:get("display"):getItemQuad("key")
			if count == 0 then
				return
			end
		end

		self.open = true
		if self.item == "key" then
			key:new(self.x, self.y)
		elseif self.item == "money" then
			player:addMoney(5)
		elseif self.item == "shell" then
			player:getShell(self.itemType)
			event:load("fanfare", CUTSCENES["fanfare"][1])
		end
	end, false, true, nil, function(player)
		return self.static == false
	end)

	table.insert(layer, self)
end

function chest:update(dt)
	if self.open then
		if self.quadi < #chestQuads then
			self.timer = self.timer + 8 * dt
			self.quadi = math.floor(self.timer % #chestQuads) + 1
		end
	end
	self.useRectangle:setPosition(self.x, self.y)
	self.useRectangle:update(dt)
end

function chest:draw()
	if self.visible then
		love.graphics.draw(chestImage, chestQuads[self.quadi], self.x + (16 - 28) / 2, self.y, 0, self.scale, 1, self:getXOffset())
	end
end

function chest:use(t)
	if self.open then
		return
	end

	if t == "on" then
		self.visible = true
		self.static = false
	elseif t == "off" then
		self.y = self.y - self.height
		self.visible = false
		self.static = true
	end
end