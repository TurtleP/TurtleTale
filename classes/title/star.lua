local star = class("star")

function star:initialize(x, y)
	self.x = x
	self.y = y

	self.width = 1
	self.height = 1

	self.blinks = math.random(100) < 30

	self.timer = 0
	self.fade = 1
end

function star:update(dt)
	if not self.blinks then
		return
	end

	self.timer = self.timer + 0.5 * dt
	self.fade = math.abs( math.sin( self.timer * math.pi ) / 2 ) + 0.5
end

function star:draw()
	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

	love.graphics.setColor(255, 255, 255, 255)
end

return star