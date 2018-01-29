particle = class("particle")

function particle:initialize(layer, x, y, speed, color)
	self.x = x
	self.y = y

	self.speed = speed

	self.gravity = 300
	self.color = color

	self.active = true

	table.insert(layer, self)

	self.lifeTime = 0
end

function particle:update(dt)
	self.lifeTime = self.lifeTime + dt
	if self.lifeTime > 1 then
		self.remove = true
	end

	local ret = checkrectangle(self.x, self.y, 2, 2, {"tile"})
	if #ret > 0 then
		print(ret[1], "!")
		self.remove = true
	end
end

function particle:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.x, self.y, 2, 2)
end