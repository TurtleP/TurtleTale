fire = class("fire", entity)

local fireImage = love.graphics.newImage("graphics/game/enemies/fire.png")
local fireQuads = {}
for i = 1, 5 do
	fireQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, fireImage:getWidth(), fireImage:getHeight())
end

function fire:initialize(layer, x, y, speed)
	entity.initialize(self, layer, x, y, 16, 16)

	self.fade = 1
	self.timer = 0
	self.quadi = 1

	self.speed = speed or vector(0, 0)

	self.rate = math.random(4, 6)
end

function fire:update(dt)
	if self.fade == 0 then
		self.remove = true
	else
		if self.speed == vector(0, 0) then
			self.fade = math.max(self.fade - dt / 0.5, 0)
		end
	end
	
	self.timer = self.timer + self.rate * dt
	self.quadi = math.floor(self.timer % #fireQuads) + 1
end

function fire:draw()
	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.draw(fireImage, fireQuads[self.quadi], self.x, self.y)

	love.graphics.setColor(255, 255, 255, 255)
end