cloud = class("cloud")

function cloud:init(x, y, speed)
	self.x = x
	self.y = y

	self.speed = speed

	self.i = math.random(1, 4)
end

function cloud:update(dt)
	local max = 400
	if state ~= "title" then
		max = tiled:getWidth("top") * 16
	end

	if self.x > max then
		self.x = -cloudImages[self.i]:getWidth()
		self.speed = math.random(30, 35)
	end

	self.x = self.x + self.speed * dt
end

function cloud:draw()
	love.graphics.setScreen("top")
	love.graphics.draw(cloudImages[self.i], self.x, self.y)
end