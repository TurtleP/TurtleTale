clock = class("clock")

local clockImage = love.graphics.newImage("graphics/game/prefabs/clock.png")
local clockQuads = {}
for i = 1, 3 do
	clockQuads[i] = love.graphics.newQuad((i - 1) * 15, 0, 15, 32, clockImage:getWidth(), clockImage:getHeight())
end

function clock:initialize(layer, x, y)
	self.x = x
	self.y = y

	self.animation = {1, 2, 3, 2}

	self.timer = 0
	self.quadi = 1
	
	self.active = true
	self.static = true

	table.insert(layer, self)
end

function clock:update(dt)
	self.timer = self.timer + 2 * dt
	self.quadi = self.animation[math.floor(self.timer % #self.animation) + 1]
end

function clock:draw()
	love.graphics.draw(clockImage, clockQuads[self.quadi], self.x, self.y)
end