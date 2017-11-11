fireball = class("fireball")

local fireImage = love.graphics.newImage("graphics/game/enemies/fire.png")
local fireQuads = {}
for i = 1, 5 do
	fireQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, fireImage:getWidth(), fireImage:getHeight())
end

function fireball:init(x, y, speed)
	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.mask = {false}

	self.speedx = speed[1]
	self.speedy = speed[2]

	self.gravity = 0
	self.active = true

	self.timer = 0
	self.quadi = 1

	self.rate = math.random(4, 6)

	self.fade = 1
end

function fireball:update(dt)
	self.timer = self.timer + self.rate * dt
	self.quadi = math.floor(self.timer % #fireQuads) + 1

	if self.speedx == 0 and self.speedy == 0 then
		self.fade = math.max(self.fade - 0.2 * dt, 0)
		if self.fade < 0 then
			self.remove = true
		end
	end
end

function fireball:draw()
	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.draw(fireImage, fireQuads[self.quadi], self.x, self.y)
end

function fireball:setPosition(x, y, stop)
	self.x = x
	self.y = y

	if stop then
		self.speedx = 0
		self.speedy = 0
	end
end