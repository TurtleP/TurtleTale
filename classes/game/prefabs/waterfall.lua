waterfall = class("waterfall")

local waterfallImage = love.graphics.newImage("graphics/game/prefabs/waterfall.png")
local waterfallQuads = {}
for i = 1, 7 do
	waterfallQuads[i] = love.graphics.newQuad((i - 1) * 17, 0, 16, 32, waterfallImage:getWidth(), waterfallImage:getHeight())
end

function waterfall:initialize(layer, x, y, height)
	self.x = x
	self.y = y

	self.height = height

	self.timer = 0
	self.quadi = 1

	self.active = true
	self.static = true

	table.insert(layer, self)
end

function waterfall:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % 7) + 1
end

function waterfall:draw()
	for i = 1, self.height / 32 do
		love.graphics.draw(waterfallImage, waterfallQuads[self.quadi], self.x, self.y + (i - 1) * 32)
	end
end