crate = class("crate")

function crate:init(x, y)
	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.active = true

	self.speedx = 0
	self.speedy = 0

	self.gravity = 3840
	self.category = 5

	self.mask = {true, false, false, false, true}

	self.quadi = 1

	self.fade = 1
end

function crate:damage(amount)
	self.quadi = math.min(self.quadi + amount, #crateQuads)
end

function crate:update(dt)
	if self.quadi == #crateQuads then
		self.fade = self.fade - dt
		self.static = true
		self.passive = true
		if self.fade < 0 then
			self.remove = true
		end
	end
end

function crate:draw()
	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.draw(crateImage, crateQuads[self.quadi], self.x, self.y)

	love.graphics.setColor(255, 255, 255, 255)
end