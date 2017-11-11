container = class("container")

local containerImage = love.graphics.newImage("graphics/game/container.png")
local containerQuads = {}
for i = 1, 6 do
	containerQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 14, containerImage:getWidth(), containerImage:getHeight())
end

function container:init(x, y)
	self.x = x
	self.y = y

	self.width = 16
	self.height = 14

	self.quadi = 1
	self.timer = 0

	self.active = true
	self.gravity = 100

	self.mask = { true }

	self.speedx = 0
	self.speedy = 0
end

function container:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #containerQuads) + 1
end

function container:draw()
	love.graphics.draw(containerImage, containerQuads[self.quadi], self.x, self.y)
end

function container:collect(turtle)
	if not self.remove then
		turtle:addHeart()
		fanfareSound:play()
		gameHUD:reset()
		gameNewDialog(nil, "You got a heart container! Your health has been restored and max hearts increased by one!")
		self.remove = true
	end
end