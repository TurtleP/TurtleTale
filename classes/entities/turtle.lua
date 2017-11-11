turtle = class("turtle", entity)

local turtleImage = love.graphics.newImage("graphics/player/turtle.png")
local turtleQuads = {}
local turtleAnimations = { {"idle", 4}, {"walk", 4}, {"jump", 3}, {"dead", 6}, {"duck", 6}, {"unduck", 5}, {"spin", 5}, {"punch", 4}, {"climb", 6} }

for y = 1, #turtleAnimations do
	turtleQuads[turtleAnimations[y][1]] = {}
	for x = 1, turtleAnimations[y][2] do
		table.insert(turtleQuads[turtleAnimations[y][1]], love.graphics.newQuad((x - 1) * 12, (y - 1) * 20, 12, 20, turtleImage:getWidth(), turtleImage:getHeight()))
	end
end

function turtle:init(x, y)
	entity.init(self, x, y)

	self.x = x
	self.y = y

	self.width = 12
	self.height = 14

	self.timer = 0
	self.quadi = 1

	self.state = "idle"

	self.screen = "top"

	self.active = true

	self.gravity = turtleGravity
	
	self.speedx = 0
	self.speedy = 0

	self.category = 2

	self.mask =
	{
		true, false, true, 
		false, true, true,
		false
	}

	self.rightKey = false
	self.leftKey = false
	self.downKey = false
	self.abilityKey = false

	self.useKey = false
	self.ducking = false

	self.punching = false

	local abilities = {
		["punch"] = false,
		["watergun"] = false
	}

	self.abilities = saveManager:getSaveData().abilities or abilities

	self.walkSpeed = 2
	self.maxWalkSpeed = 80

	self.scale = saveManager:getSaveData().scale or 1
	self.offsetX = 0

	self.health = saveManager:getSaveData().health or 3
	self.maxHealth = saveManager:getSaveData().maxHealth or 3

	self.render = true

	self.frozen = false

	self.invincible = false

	self.disableTimer = 0
	self.invincibleTimer = 0
	self.punchCoolDown = 0
	self.punchTimer = turtlePunchDuration

	self.changeMap = false

	self.last = {0, 0}

	self.money = saveManager:getSaveData().money or 0

	if not self.inventory then
		self.inventory = inventory:new()
	end

	local hasKey, keyObject = saveManager:getSaveData().key, nil;
	if hasKey then
		keyObject = key:new(self.x, self.y)
	end
	self.key = keyObject
end

function turtle:update(dt)
	if self.dead then
		self:setState("dead")
		if self.quadi < #turtleQuads[self.state] then
			self.timer = self.timer + 8 * dt
			self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1
		end
		return
	end

	if self.y > util.getHeight() then
		self:die("pit")
	end

	if self.state ~= "punch" then
		local add = 0
		if self.state == "spin" then
			add = 80
		end

		if self.rightKey then
			self.speedx = self.maxWalkSpeed + add

			self:setScale(1)
		elseif self.leftKey then
			self.speedx = -self.maxWalkSpeed - add

			self:setScale(-1)
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

	if self.onLadder then
		if self.useKey then
			self.speedy = -80
		elseif self.downKey then
			self.speedy = 80
		elseif not self.useKey and not self.downKey then
			self.speedy = 0
		end
	end

	if not self.abilities[self.state] then
		if not self.state:find("duck") then
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
				end
			elseif self.speedx == 0 and self.speedy == 0 and not self.onLadder then
				self:setState("idle")
				self.timer = self.timer + 6 * dt
			end
			
			if self.speedy ~= 0 then
				if not self.onLadder then
					self:setState("jump")
					if self.quadi < 3 then
						self.timer = self.timer + 4 * dt
					end
				else
					self:setState("climb")
					self.timer = self.timer + 12 * dt
				end
			end
		end
	else
		if self.state == "punch" then
			self.timer = self.timer + 14 * dt

			local add = self.width + 12
			if self.scale == -1 then
				add = -12
			end

			self.punchTimer = self.punchTimer - dt
			if self.punchTimer < 0 then
				self.punching = false
				self:setState("idle")
				self.punchTimer = turtlePunchDuration
			end
		end
	end

	if not self.onLadder then
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

	if self.abilities["spin"] then
		if self.speedx ~= 0 and self.ducking then
			if self.state == "duck" then
				if self.quadi == #turtleQuads[self.state] then
					self:setState("spin")
				end
			end
			self.timer = self.timer + 15 * dt
		end
	end

	local ret = checkrectangle(self.x + self.speedx * dt, self.y, self.width, self.height, {"tile"})

	if #ret == 0 then
		self:dropLadder()
	else
		if ret[1][2].ladder then
			self:checkLadder(ret[1][2])
		end
	end

	if self.invincible then
		self.invincibleTimer = self.invincibleTimer + 8 / 0.8 * dt

		if self.invincibleTimer > 10 then
			self.invincibleTimer = 0
			self.invincible = false
		end
	end

	self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1

	if self.key then
		self.key:update(dt)
	end
end

function turtle:draw()
	if self.key then
		self.key:draw()
	end

	if not self.render or (math.floor(self.invincibleTimer) % 2 == 0 and self.invincible) then
		return
	end

	local offsetY = 6
	if self.ducking then
		offsetY = 12
	end
	love.graphics.draw(turtleImage, turtleQuads[self.state][self.quadi], self.x + self.offsetX, self.y - offsetY, 0, self.scale, 1)
end

function turtle:rightCollide(name, data)
	if name == "tile" then
		if data.breakable and self.punching then
			data:destroy()
		end

		if data.ladder then
			return false
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

	if name == "spider" then
		self:addLife(-1)
		return false
	end

	if name == "hermit" or name == "bat" or name == "boss" then
		if name == "hermit" and not data.evil then
			return false
		elseif name == "boss" and data.type == "hermit" then
			if data.speedx ~= 0 and not data:isInvincible() then
				self:addLife(-1)
				return false
			end
		end

		if not data:isInvincible() then
			if not data:isPunched() then
				if self.punching then
					data:getPunched(self.scale)
					self.speedx = -self.speedx
				else
					self:addLife(-1)
				end
			end
			return false
		end
		return false
	end
end

function turtle:leftCollide(name, data)
	if name == "tile" then
		if data.breakable and self.punching then
			data:destroy()
		end

		if data.ladder then
			return false
		end
	end

	if name == "spider" then
		self:addLife(-1)
		return false
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

	if name == "hermit" or name == "bat" or name == "boss" then
		if name == "hermit" and not data.evil then
			return false
		elseif name == "boss" and data.type == "hermit" then
			if data.speedx ~= 0 and not data:isInvincible() then
				self:addLife(-1)
				return false
			end
		end

		if not data:isInvincible() then
			if not data:isPunched() then
				if self.punching then
					data:getPunched(self.scale)
					self.speedx = -self.speedx
				else
					self:addLife(-1)
				end
			end
			return false
		end
		return false
	end
end

function turtle:upCollide(name, data)
	if name == "hermit" or name == "bat" or name == "boss" then
		return false
	end

	if name == "spider" then
		self:addLife(-1)
		return false
	end

	if name == "tile" then
		if data.ladder then
			return false
		end
	end
end

function turtle:downCollide(name, data)
	self.jumping = false

	if name == "hermit" or name == "bat" or name == "boss" then
		return false
	end

	if name == "spider" then
		self:hop()
		data:die()
		return false
	end

	if name == "tile" then
		self.last = {self.x, data.y - self.height}

		if data.ladder then
			if self.y < data.y then
				if self.downKey or self.onLadder then
					return false
				end
			else
				if not self.onLadder then
					return false
				end
			end
		end
	end
end

function turtle:passiveCollide(name, data)
	if name == "health" or name == "coin" or name == "container" then
		data:collect(self)
		return false
	end

	if name == "tile" then
		if data.breakable and self.punching then
			data:destroy()
		end
	end
end

function turtle:checkLadder(data)
	if not self.onLadder then
		if (self.y + self.height > data.y) or (self.y < data.y) then
			if self.useKey or self.downKey then
				self.gravity = 0
				self.x = (data.x + data.width / 2) - self.width / 2
				self:setState("climb")
				self.ducking = false
				self:unDuck()
				self.onLadder = true

				data.passive = true
				self.lastLadder = data
			end
		end
	end
end

function turtle:dropLadder(data)
	if self.onLadder then
		self.gravity = turtleGravity
		self.speedy = 0

		if self.lastLadder then
			self.lastLadder.passive = false
		end
		self.lastLadder = nil
		self.onLadder = false
	end
end

function turtle:addLife(health, isPit)
	if not isPit then
		if self.state == "duck" then
			return
		end
	end

	if health < 0 then
		if not self.invincible then
			if self.health < 2 then
				self.inventory:use("auto")
			end

			self.invincible = true
		else
			return
		end
	end
	
	if turtleInvincible then
		return
	end

	self.health = util.clamp(self.health + health, 0, self.maxHealth)
	gameHUD:reset(true)

	if self.health == 0 then
		self:die()
	end
end

function turtle:die(pit) -- rip :(

	if pit then
		if not self.teleport then
			pitDeathSound:play()
			self:addLife(-1, true)
		
			if self.health > 0 then
				self:reset(SPAWN_X, SPAWN_Y)
				return
			end
		else
			return
		end
	end

	if not self.dead then
		self.speedx = 0
		self.speedy = 0

		self.dead = true
		self.render = true
		self.invincibleTimer = 0
		self.invincible = false

		util.changeState("gameOver")
	end
end

function turtle:setScale(scale)
	if scale == self.scale then
		return
	end

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
	--self:setState("idle")

	self:use(false)
	--self:duck(false)
end

function turtle:moveRight(move)
	self.rightKey = move
end

function turtle:moveLeft(move)
	self.leftKey = move
end

function turtle:duck(move)
	self.downKey = move

	if self.onLadder then
		return
	end

	if move then
		if self.speedx ~= 0 then
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

		self:setState(state)
	else
		if self.state == "duck" then
			state = "unduck"

			if self.rightKey then
				self.rightKey = false
			end

			if self.leftKey then
				self.leftKey = false
			end

			self:unDuck()
			self:setState(state)
		end
	end

	
	self.ducking = move
end

function turtle:isDucking()
	return self.ducking
end

function turtle:unDuck()
	if self.height ~= 14 then
		self.height = 14
		self.y = self.y - 6
	end
end

function turtle:jump()
	if self.onLadder then
		return
	end

	if self.speedy == 0 and not self.jumping and not self.dead then
		
		local speed = self.speedx
		if self.punching then
			self.speed = self.maxWalkSpeed
		end
		self.speedy = -jumpForce - (math.abs(speed) / self.maxWalkSpeed) * jumpForceAdd * 0.5

		if self.ducking then
			self.speedy = self.speedy * 0.75
		end

		jumpSound:play()

		self.jumping = true
	end
end

function turtle:hop() --how?
	self.speedy = -self.speedy / 2
	jumpSound:play()
	self.jumping = true
end

function turtle:stopJump()
	if self.speedy < 0 then
		self.speedy = self.speedy * 0.05
	end
end

function turtle:punch(move)
	if self.frozen then
		return
	end
	
	self.abilityKey = move

	if not self.abilities["punch"] or self.ducking then
		return
	end

	if move then
		self:setState("punch")
		chargeSound:play()
	else
		self:setState("idle")
		self.punchTimer = turtlePunchDuration
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

function turtle:addHeart()
	self.maxHealth = self.maxHealth + 1
	self:addLife(self.maxHealth)
end

function turtle:hasLowHealth()
	return self.health < self.maxHealth
end

function turtle:isDead()
	return self.health == 0
end

function turtle:getAbility(name)
	if not self.abilities[name] then
		self.abilities[name] = true
	end
end

function turtle:hasAbility(name)
	return self.abilities[name]
end

function turtle:getMoney()
	return self.money
end

function turtle:addMoney(amount)
	self.money = math.max(self.money + amount, 0)
end

function turtle:reset(x, y)
	self.x = x
	self.y = y

	self:moveRight(false)
	self:moveLeft(false)
	self:punch(false)

	self.speedx = 0
	self.teleport = false

	if self.key then
		self.key:adjust()
	end
	
	self:setState("idle")
end