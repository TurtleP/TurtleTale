droplet = class("droplet")

function droplet:init(x, y, speed)
	self.x = x
	self.y = y

	self.width = 1
	self.height = 1

	self.speedx = speed[1]
	self.speedy = speed[2]

	self.gravity = 400
end

function droplet:update(dt)
	self.speedy = self.speedy + self.gravity * dt

	self.x = self.x + self.speedx * dt
	self.y = self.y + self.speedy * dt
end

function droplet:draw()
	love.graphics.setColor(0, 200, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end