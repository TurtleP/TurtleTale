rock = class("rock")

function rock:init(x, y, speed, color, hurt)
	self.x = x
	self.y = y

	self.width = 2
	self.height = 2

	if not speed then
		speed = {0, 0}
	end

	self.speedx = speed[1] or 0
	self.speedy = speed[2] or 0

	self.gravity = 480

	self.color = color or {55, 80, 102}

	if hurt == nil then
		hurt = true
	end
	self.isDeadly = hurt
end

function rock:update(dt)
	if self.isDeadly then
		local ret = checkrectangle(self.x, self.y, self.width * 2, self.height * 2, {"player"})
		if #ret > 0 then
			ret[1][2]:addLife(-1)
		end
	end

	self.x = self.x + self.speedx * dt
	self.speedy = self.speedy + self.gravity * dt

	self.y = self.y + self.speedy * dt

	if self.y > util.getHeight() then
		self.remove = true
	end
end

function rock:draw()
	love.graphics.setColor(self.color)
	love.graphics.circle("fill", self.x, self.y, self.width)
	love.graphics.setColor(255, 255, 255)
end