turtle = class("turtle")

function turtle:init(x, y)
	self.x = x
	self.y = y

	self.width = 12
	self.height = 14

	self.timer = 0
	self.quadi = 1

	self.state = "idle"

	self.screen = "top"

	self.active = true

	self.gravity = 360
	
	self.speedx = 0
	self.speedy = 0

	self.category = 2

	self.mask =
	{
		true, false, true, false, true
	}

	self.rightKey = false
	self.leftKey = false
	self.useKey = false
	self.ducking = false

	self.punching = false

	self.abilities = 
	{
		["punch"] = true,
		["duck"] = true,
		["unduck"] = true,
		["spin"] = true
	}

	self.walkSpeed = 2
	self.maxWalkSpeed = 80

	self.scale = scale
	self.offsetX = 0

	self.health = saveManager:getSaveData()[2] or 3
	self.maxHealth = saveManager:getSaveData()[3] or 3

	self.render = true

	self.frozen = false

	self.invincible = false

	self.disableTimer = 0
	self.invincibleTimer = 0
	self.punchCoolDown = 0

	self.changeMap = false

	self.last = {false, false}
end

function turtle:update(dt)
	if self.dead then
		self:setState("dead")
		if self.quadi < #turtleQuads[self.state] then
			self.timer = self.timer + 6 * dt
			self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1
		end

		gameOver = true

		return
	end

	if self.y > love.graphics.getHeight() then
		self:die("pit")
	end

	if self.state ~= "punch" then
		local add = 0
		if self.state == "spin" then
			add = 80
		end

		if self.rightKey then
			self.speedx = self.maxWalkSpeed + add

			self:setScale(scale)
		elseif self.leftKey then
			self.speedx = -self.maxWalkSpeed - add

			self:setScale(-scale)
		elseif not self.rightKey and not self.leftKey then
			self.speedx = 0
		end
	else
		if self.punching then
			if self.punchCoolDown > 0 then
				self.punchCoolDown = math.max(self.punchCoolDown - dt, 0)
				return
			end
			
			if self.scale == 1 then
				self.speedx = self.maxWalkSpeed + 15
			else
				self.speedx = -self.maxWalkSpeed - 15
			end
		end
	end

	if not self.abilities[self.state] then
		if self.speedx ~= 0 then
			if not self.ducking then
				local modifier = 2

				if self.rightKey then
					if self.speedx < 0 then
						self.speedx = math.min(self.speedx + modifier, 0)
					end
				elseif self.leftKey then
					if self.speedx > 0 then
						self.speedx = math.max(self.speedx - modifier, 0)
					end
				end

				if not self.jumping then
					self:setState("walk")
					self.timer = self.timer + math.abs(self.speedx) * 0.1 * dt
				end
			else
				self.timer = self.timer + 10 * dt
			end
		elseif self.speedx == 0 and self.speedy == 0 then
			self:setState("idle")
			self.timer = self.timer + 6 * dt
		end
		
		if self.speedy ~= 0 then
			self:setState("jump")
			if self.quadi < 3 then
				self.timer = self.timer + 4 * dt
			end
		end
	else
		if self.state == "punch" then
			self.timer = self.timer + 14 * dt

			local add = self.width + 12
			if self.scale == -1 then
				add = -12
			end

			local check = checkrectangle(self.x + add, self.y + 8, 4, 4, {"hermit"})
			if #check > 0 then
				local v = check[1][2]
				v:shake(math.random(1, 2))
			end
		end

		if self.state:find("duck") then
			if self.quadi < #turtleQuads[self.state] then
				self.timer = self.timer + 12 * dt
			else
				if self.state == "unduck" then
					self:setState("idle")
				end
			end
		end
	end

	if self.speedx ~= 0 and self.ducking then
		if self.state == "duck" then
			if self.quadi == #turtleQuads[self.state] then
				self:setState("spin")
			end
		end
		self.timer = self.timer + 15 * dt
	end

	if not love.keyboard.isDown(controls["down"]) then --gg ez
		if self.state == "spin" then
			self:duck(false)
		end
	end

	if self.invincible then
		self.invincibleTimer = self.invincibleTimer + 8 / 0.8 * dt

		if self.invincibleTimer > 16 then
			self.invincibleTimer = 0
			self.invincible = false
		end
	end

	self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1
end

function turtle:draw()
	if not self.render or (math.floor(self.invincibleTimer) % 2 == 0 and self.invincible) then
		return
	end

	local offsetY = 6
	if self.ducking then
		offsetY = 12
	end

	love.graphics.draw(turtleImage, turtleQuads[self.state][self.quadi], self.x + self.offsetX, self.y - offsetY, 0, self.scale, scale)
end

function turtle:rightCollide(name, data)
	if name == "hermit" then
		self:addLife(-1)
		return false
	end

	if name == "tile" then
		if self.state == "spin" then
			self:duck(false)
		end
	end

	if name == "crate" then
		if self.state == "punch" then
			self.speedx = -self.speedx / 2
			
			if not self.jumping then
				self.speedy = -75
			end
			
			self.punchCoolDown = 0.5
			data:damage(1)

			return false
		end
	end
end

function turtle:leftCollide(name, data)
	if name == "hermit" then
		self:addLife(-1)
		return false
	end

	if name == "tile" then
		if self.state == "spin" then
			self:duck(false)
		end
	end

	if name == "crate" then
		if self.state == "punch" then
			if data.fade ~= 1 then
				return
			end
			
			self.speedx = -self.speedx / 2

			if not self.jumping then
				self.speedy = -75
			end

			self.punchCoolDown = 0.5
			data:damage(1)

			return false
		end
	end
end

function turtle:upCollide(name, data)
	if name == "hermit" then
		self:addLife(-1)
		return false
	end
end

function turtle:downCollide(name, data)
	self.jumping = false

	if name == "hermit" then
		self:addLife(-1)
		return false
	end

	if name == "tile" then
		self.last = {self.x, data.y - self.height}
	end
end

function turtle:addLife(health)
	if self.state == "duck" then
		return
	end

	if health < 0 then
		if not self.invincible then
			self.invincible = true
		else
			return
		end
	end
	
	self.health = math.max(self.health + health, 0)

	if self.health == 0 then
		self:die()
	end
end

function turtle:die(pit) -- rip :(

	if pit then
		shakeValue = 4
		pitDeathSound:play()
		self:addLife(-1)
	
		if self.health > 0 then
			self.x = self.last[1]
			self.y = self.last[2]
			
			self.speedx = 0
			self.speedy = 0

			self:duck(false)
			
			return
		end
	end

	if not self.dead then
		self.speedx = 0
		self.speedy = 0

		self.dead = true
	end
end

function turtle:setScale(scale)
	if scale == 1 then
		self.offsetX = 0
	else
		self.offsetX = self.width
	end
	self.scale = scale
end

function turtle:use(move)
	self.useKey = move
end

function turtle:freeze(freeze)
	self.frozen = freeze

	self.speedx = 0
	self.speedy = 0
	self.timer = 0

	self:duck(false)
end

function turtle:moveRight(move)
	if self.ducking and not self.frozen then
		if not move or (move and self.state == "spin") then
			return
		end
	end
	self.rightKey = move
end

function turtle:moveLeft(move)
	if self.ducking and not self.frozen then
		if not move or (move and self.state == "spin") then
			return
		end
	end
	self.leftKey = move
end

function turtle:duck(move)
	if self.speedy ~= 0 then
		return
	end

	if move then
		if self.state == "spin" then
			return
		end
	end

	local state = "duck"
	
	if move then
		duckSound:play()
		
		if self.height ~= 8 then
			self.height = 8
			self.y = self.y + 6
		end
	else
		if self.state == "duck" or self.state == "spin" then
			state = "unduck"

			if self.rightKey then
				self.rightKey = false
			end

			if self.leftKey then
				self.leftKey = false
			end

			if self.height ~= 14 then
				self.height = 14
				self.y = self.y - 6
			end
		else
			return
		end
	end

	self:setState(state)
	self.ducking = move
end

function turtle:jump()
	if not self.jumping and not self.dead then
		
		self.speedy = -jumpForce - (math.abs(self.speedx) / self.maxWalkSpeed) * jumpForceAdd * 0.5

		if self.ducking then
			self.speedy = self.speedy * 0.75
		end

		jumpSound:play()

		self.jumping = true
	end
end

function turtle:stopJump()
	if self.speedy < 0 then
		self.speedy = self.speedy * 0.05
	end
end

function turtle:punch(move)
	if move then
		self:setState("punch")
		chargeSound:play()
	else
		self:setState("idle")
	end
	self.punching = move
end

function turtle:setState(state)
	if self.state ~= state then
		self.quadi = 1
		self.timer = 0
		self.state = state
	end
end

function turtle:setRender(render)
	self.render = render
end

function turtle:getHealth()
	return self.health
end

function turtle:getMaxHealth()
	return self.maxHealth
end