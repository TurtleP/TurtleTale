chest = class("chest", object)

local chestImage = love.graphics.newImage("graphics/game/chest.png")
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

	self.mask = { true }

	for k, v in pairs(properties) do
		if type(k) == "string" then
			self[k] = v
		end
	end

	self.useRectangle = userectangle:new(self.x + (16 - 28) / 2, self.y, self.width, self.height, function(player)
		self.open = true
		if self.item == "key" then
			key:new(self.x, self.y)
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
		print("nani the fuck")
		self.visible = true
		self.static = false
	elseif t == "off" then
		self.y = self.y - self.height
		self.visible = false
		self.static = true
	end
end