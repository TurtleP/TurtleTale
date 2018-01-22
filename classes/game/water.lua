water = class("water")

local waterImage = love.graphics.newImage("graphics/game/water.png")
local waterQuads = {}
for i = 1, 7 do
	waterQuads[i] = love.graphics.newQuad((i - 1) * 17, 0, 16, 16, waterImage:getWidth(), waterImage:getHeight())
end

function water:initialize(layer, x, y, width, height)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	self.timer = 0
	self.quadi = 1

	table.insert(layer, self)
	self.layer = layer

	self.splash = false
end

function water:update(dt)
	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % 6) + 1

	local ret = checkrectangle(self.x, self.y, self.width, 1, {"player"})

	if #ret > 0 and not self.splash then
		particle:new(self.layer, ret[1][2].x, self.y, vector(-40, -64), {58, 94, 101})
		particle:new(self.layer, ret[1][2].x, self.y, vector(40, -64), {58, 94, 101})
		self.splash = true
	else
		self.splash = false
	end
end

function water:draw()
	for x = 1, self.width / 16 do
		love.graphics.draw(waterImage, waterQuads[self.quadi], self.x + (x - 1) * 16, self.y)
		for y = 2, self.height / 16 do
			love.graphics.draw(waterImage, waterQuads[7], self.x + (x - 1) * 16, self.y + (y - 1) * 16)
		end
	end
end