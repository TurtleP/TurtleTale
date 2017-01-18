hitnumber = class("hitnumber")

function hitnumber:init(x, y, damage)
	self.x = x
	self.y = y

	self.text = tostring(damage)

	self.speedy = 32
	self.fade = 1

	self.riseTimer = 0
	self.doneRising = false

	self.remove = false
end

function hitnumber:update(dt)
	self.y = self.y - self.speedy * dt

	self.fade = math.max(self.fade - 0.6 * dt, 0)

	if self.fade == 0 then
		self.remove = true
	end	
end

function hitnumber:draw()
	love.graphics.setColor(0, 0, 0, 255 * self.fade)
	love.graphics.draw(hitNumbersImage, hitNumbersQuads[self.text], self.x - 1, self.y - 1)

	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.draw(hitNumbersImage, hitNumbersQuads[self.text], self.x, self.y)

	love.graphics.setColor(255, 255, 255, 255)
end