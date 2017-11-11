batboss = class("batboss", bat)

function batboss:init(x, y)
	bat.init(self, x, y)

	self.intro = true
	self.flySpeed = 176

	self.gravity = 0

	self.state = "fly"

	self.reverse = false

	self.diveTimer = math.random(2)

	self.angle = nil

	self.health = 3
	self.invincible = false
	self.invincibleTimer = 0

	self:reset()
end

function batboss:update(dt)
	self:updateDirection(dt)

	self.squeakTimer = self.squeakTimer - dt
	if self.squeakTimer < 0 then
		batChaseSound:play()
		self.squeakTimer = math.random(1, 2)
	end

	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #self.quad[self.state]) + 1

	if not self.invincible then
		self.diveTimer = self.diveTimer - dt
		if self.diveTimer < 0 then
			if not self.angle then
				self.angle = self:getPlayerAngle()
			else
				self.speedx = math.cos(self.angle) * self.flySpeed
				self.speedy = math.sin(self.angle) * self.flySpeed
			end
		end
	else
		self.invincibleTimer = self.invincibleTimer + 8 / 0.8 * dt
	end
	
	if self.y < -self.height or self.y > util.getHeight() or self.x < 0 or self.x > tiled:getWidth() * 16 then
		self:reset()
		self.diveTimer = math.random(2)
	end
end

function batboss:draw()
	if self.invincible then
		if self.invincibleTimer > 0 and math.floor(self.invincibleTimer) % 2 == 0 then
			return
		end
	end

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.graphic, self.quad[self.state][self.quadi], self.x + self:getOffset(), self.y, 0, self.scale)
end

function batboss:addLife()
	if not self.invincible then
		bat.addLife(self)
		self.speedx = -self.speedx
		self.speedy = -self.speedy
		self.invincible = true
	end
end

function batboss:reset()
	self.x = math.random(0, (tiled:getWidth() * 16) - self.width)

	local coords = {-self.height, 240}
	self.y = coords[math.random(#coords)]
	
	self.speedx = 0
	self.speedy = 0
	self.angle = nil

	self.invincibleTimer = 0
	self.invincible = false

	if self.health == 2 then
		if self.flySpeed ~= 192 then
			self.flySpeed = 192
		end
	end
end