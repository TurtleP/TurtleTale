phoenix = class("phoenix")

function phoenix:init(x, y)
	self.x = x
	self.y = y

	self.width = 76
	self.height = 50

	self.animations =
	{
		["flight"] = {rate = 8, anim = {1, 2, 3, 2}},
		["glide"] = {rate = 2, anim = {4, 5}}
	}

	self.mask = {}
	
	self.state = "flight"

	self.timer = 0
	self.quadi = 1
	self.offset = 0
	
	self.active = true
	
	self.speedx = 0
	self.speedy = 0
	
	self.gravity = 0

	self.fireTimer = 0.05
	self.fireDuration = 2
	self.scale = 1

	self.offsetX = 0
end

function phoenix:update(dt)
	self.timer = self.timer + self.animations[self.state].rate * dt
	self.quadi = self.animations[self.state].anim[math.floor(self.timer % #self.animations[self.state].anim) + 1]

	if self.state == "glide" then
		if self.speedx == 0 and self.speedy == 0 then
			self.offset = math.sin(love.timer.getTime() * 6) * 4
		else
			self.offset = 0
		end
	else
		self.offset = math.sin(love.timer.getTime() * 6) * 4
	end

	if self.flameThrower then
		if self.fireDuration > 0 then
			if self.fireTimer > 0 then
				self.fireTimer = self.fireTimer - dt
			else
				table.insert(objects["fireball"], fireball:new(self.x + 12, self.y + 12 + self.offset, {-200, 200}))
				self.fireTimer = 0.05
			end
			self.fireDuration = self.fireDuration - dt
		else
			self.flameThrower = false
		end
	end
end

function phoenix:flamethrower(dir)
	self.flameThrower = true
end

function phoenix:draw()
	love.graphics.draw(phoenixImage, phoenixQuads[self.quadi], self.x + self.offsetX, self.y + self.offset, 0, self.scale, self.scale)
end

function phoenix:setScale(scale)
	self.scale = scale

	if scale == 1 then
		self.offsetX = 0
	elseif scale == -1 then
		self.offsetX = self.width		
	end
end

function phoenix:setState(state)
	if self.state ~= state then
		self.timer = 0
		self.quadi = 1
		self.state = state
	end
end