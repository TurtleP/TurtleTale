fish = class("fish")

local fishImage = love.graphics.newImage("graphics/game/enemies/fish.png")
local fishQuads = {}
for i = 1, 6 do
	fishQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, fishImage:getWidth(), fishImage:getHeight())
end

function fish:init(x, y)
	self.x = x
	self.y = y

	self.width = 16
	self.height = 11

	self.active = true
	self.passive = true

	self.gravity = 400

	self.speedx = speed[1]
	self.speedy = speed[2]

	self.timer = 0 
	self.quadi = 1
end

function fish:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % 2) + 1
end

function fish:draw()
	local scale, offset = 1, 0
	if self.speedx > 0 then
		scale = -1
		offset = self.width
	end

	love.graphics.draw(fishImage, fishQuads[self.quadi], self.x + offset, self.y, 0, scale)
end