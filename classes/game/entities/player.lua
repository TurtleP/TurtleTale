player = class("player", entity)

local shells = love.filesystem.getDirectoryItems("graphics/game/objects/player")
playerShells = {}
for i = 1, #shells do
	playerShells[i] = love.graphics.newImage("graphics/game/objects/player/" .. i .. ".png")
end

local turtleImage = playerShells[1]
local turtleQuads = {}
local turtleAnimations = { {"idle", 4}, {"walk", 4}, {"jump", 3}, {"dead", 6}, {"duck", 6}, {"unduck", 5}, {"carry", 3}, {"punch", 4}, {"climb", 6} }

for y = 1, #turtleAnimations do
	turtleQuads[turtleAnimations[y][1]] = {}
	for x = 1, turtleAnimations[y][2] do
		table.insert(turtleQuads[turtleAnimations[y][1]], love.graphics.newQuad((x - 1) * 12, (y - 1) * 20, 12, 20, turtleImage:getWidth(), turtleImage:getHeight()))
	end
end

local jumpSound = love.audio.newSource("audio/jump.ogg", "static")
local duckSound = love.audio.newSource("audio/duck.ogg", "static")
local healthSound = love.audio.newSource("audio/health.ogg", "static")

local inventory = require "classes.game.menu.inventory"

function player:initialize(x, y)
	entity.initialize(self, nil, x, y, 12, 14)

	self.category = 2
	self.gravity = 360

	self.mask = 
	{ 
		true, false, true,
		false, true, true,
		true, true, true,
		true, true
	}
	
	self.money = 0
	
	self.maxHealth = 3
	self.health = self.maxHealth

	self.abilities = 
	{
		punch = false
	}

	self.quadi = 1
	self.state = "idle"

	self.timer = 0

	self.jumping = false
	self.rightkey = false
	self.leftkey = false
	self.useKey = false
	self.downKey = false

	self.ducking = false
	self.punching = false

	self.freeze = false
	self.scale = 1

	self.animationRules =
	{
		idle = {rate = 6, stop = false},
		walk = {rate = 6, stop = false},
		jump = {rate = 4, stop = true, exception = "walk"},
		dead = {rate = 8, stop = true},
		duck = {rate = 8, stop = true},
		unduck = {rate = 8, stop = true, func = function() 
			self:setState("idle") 
			self.y = self.y - 6
			self.height = 14 
			self.ducking = false
		end},
		climb = {rate = 10, stop = false, condition = function()
			return self.speed.y ~= 0
		end},
		punch = {rate = 14, stop = false},
		carry = {rate = 6, stop = false}
	}

	self.invincible = false
	self.invincibleTimer = 0

	self.bashTimer = 0.75
	self.deathDelay = 1

	self.graphic = 1
	self.inventory = inventory:new()
end

function player:animate(dt)
	self.timer = self.timer + self.animationRules[self.state].rate * dt
	if self.animationRules[self.state].stop and self.quadi == #turtleQuads[self.state] then
		if self.animationRules[self.state].func then
			self.animationRules[self.state].func()
		end
		return
	elseif self.animationRules[self.state].condition then
		if not self.animationRules[self.state].condition() then
			return
		end
	end
	self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1
end

function player:update(dt)
	self:animate(dt)

	self:checkSplash()
	self:checkDeath(dt)

	if self.health > 0 then
		if self.state == "dead" then
			self.deathDelay = self.deathDelay - dt
			
			local map = state:get("map")
			local position = table.concat(PLAYERSPAWN, ";")
			
			if self.deathDelay < 0 and map then
				map:changeLevel(state.states["game"], map.name .. ";" .. position)
				self.deathDelay = 1
			end

			return
		end
	end

	local speed
	if not self.punching then
		if not self.ducking then
			if self.rightkey then
				speed = 80
			elseif self.leftkey then
				speed = -80
			end

			if self.onLadder then
				self.x = math.max(self.lastLadder.x, math.min(self.x, self.lastLadder.x + self.lastLadder.width - self.width))
			end
		end
	else
		speed = 95 * self.scale
	end

	if speed then
		self.speed.x = speed
	end

	if self.static then
		self.x = self.x + self.speed.x * dt
	end

	if self.punching then
		self.bashTimer = math.max(self.bashTimer - dt, 0)
		if self.bashTimer == 0 then
			self:punch(false, true)
			self.bashTimer = 0.75
		end
	end
	
	if not self.punching and not self.onLadder then
		if self.speed.y > 0 then
			self:setState("jump")
		end
	end

	local ret = checkrectangle(self.x + self.speed.x * dt, self.y, self.width, self.height, {"tile"})

	if #ret == 0 then
		self:dropLadder()
	else
		if ret[1].ladder then
			self:checkLadder(ret[1])
		end
	end

	if self.onLadder then
		if self.useKey then
			self.speed.y = -80
		elseif self.downKey then
			self.speed.y = 80
		elseif not self.useKey and not self.downKey then
			self.speed.y = 0
		end
	end

	if self.invincible then
		self.invincibleTimer = self.invincibleTimer + 10 * dt

		if self.invincibleTimer > 15 then
			self.invincible = false
			self.invincibleTimer = 0
		end
	end
end

function player:draw()
	if self.invincible and math.floor(self.invincibleTimer) % 2 == 0 then
		return
	end
	love.graphics.draw(playerShells[self.graphic], turtleQuads[self.state][self.quadi], self.x + self:getXOffset(), self.y - self:getYOffset(), 0, self.scale, 1)
end

function player:passiveCollide(name, data)
	if name == "health" or name == "shell" or name == "container" then
		data:collect(self)
	end

	if name == "sonicblast" then
		self.speed.x = (180 / 2) * data.scale
		self.speed.y = -JUMPFORCE
		data.remove = true
	end
end

function player:upCollide(name, data)
	self:globalCollide(name, data)

	if name == "tile" then
		if data.ladder then
			return false
		end
	end

	if name == "spider" then
		self:addHealth(-1)
		return false
	end

	if ENEMYFILTER[name] then
		if name == "bat" then
			if self.punching then
				data:die()
			else
				self:addHealth(-1)
			end
		elseif name == "megabat" then
			if self.punching then
				data:punch()
			else
				if not data.invincible then
					self:addHealth(-1)
				end
			end
		end
		return false
	end
end

function player:downCollide(name, data)
	self:globalCollide(name, data)

	if name == "tile" then
		if data.spikes then
			return
		elseif data.collapse then
			data:destroy()
		end

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
		else
			if self.onLadder then
				self:dropLadder()
			end
		end

		if self.jumping or self.state == "jump" then
			self.jumping = false
			self:move()
		end
	end

	if name == "crate" then
		if self.jumping or self.state == "jump" then
			self.jumping = false
			self:move()
		end

		if data.inWater then
			self.onCrate = true
		else
			self.onCrate = false
		end
	end

	if name == "spring" then
		local speed = data.height
		if love.keyboard.isDown(CONTROLS["jump"]) then
			speed = speed + 1
		end
		self.speed.y = -(speed * JUMPFORCE * 0.5)
		data:bounce()
		return false
	end

	if name == "spider" then
		self:jump(true)
		data:die()
		return false
	end

	if ENEMYFILTER[name] then
		if name == "bat" then
			if self.punching then
				data:die()
			else
				self:addHealth(-1)
			end
		elseif name == "megabat" then
			if self.punching then
				data:punch()
			else
				if not data.invincible then
					self:addHealth(-1)
				end
			end
		end
		return false
	end
end

function player:rightCollide(name, data)
	self:globalCollide(name, data)

	if name == "tile" then
		if data.ladder then
			return false
		end
	end

	if name == "crate" then
		if self.punching then
			data:setSpeedX(32)
		end
	end

	if name == "spider" then
		self:addHealth(-1)
		return false
	end

	if name == "button" then
		if self.punching then
			data:use(self)
		end
	end

	if ENEMYFILTER[name] then
		if name == "megabat" then
			if self.punching then
				data:punch()
			else
				if not data.invincible then
					self:addHealth(-1)
				end
			end
			return false
		end

		if self.punching then
			data:punch(self.scale)
		else
			if name ~= "hermit" then
				if not data.freeze then
					self:addHealth(-1)
				end
			end
		end
		return false
	end
end

function player:leftCollide(name, data)
	self:globalCollide(name, data)

	if name == "tile" then
		if data.ladder then
			return false
		end
	end

	if name == "button" then
		if self.punching then
			data:use(self)
			return false
		end
	end

	if name == "spider" then
		self:addHealth(-1)
		return false
	end
	
	if ENEMYFILTER[name] then
		if name == "megabat" then
			if self.punching then
				data:punch()
			else
				if not data.invincible then
					self:addHealth(-1)
				end
			end
			return false
		end

		if self.punching then
			data:punch(self.scale)
		else
			if name ~= "hermit" then
				if not data.freeze then
					self:addHealth(-1)
				end
			end
		end
		return false
	end
end

function player:globalCollide(name, data)
	if name == "tile" then
		if data.spikes then
			self:die("spikes")
		end
	end
end

function player:checkLadder(data)
	if not data then
		local ret = checkrectangle(self.x, self.y, self.width, self.height + 1, {"tile"})

		if #ret == 0 then
			return false
		end
		
		return ret[1].ladder and self.downKey
	end

	if not self.onLadder and not self.ducking then
		if (self.y + self.height > data.y) or (self.y < data.y) then
			if self.useKey or self.downKey then
				self.onLadder = true
				self.gravity = 0
				self.x = (data.x + data.width / 2) - self.width / 2
				self:setState("climb")

				data.passive = true
				self.lastLadder = data
			end
		end
	end
end

function player:dropLadder(data)
	if self.onLadder then
		self.gravity = 360
		self.speed.y = 0

		if self.lastLadder then
			self.lastLadder.passive = false
		end
		self.lastLadder = nil
		self.onLadder = false
		self:move()
	end
end

function player:moveRight(move)
	if self.ducking then
		return
	end

	self.rightkey = move
	
	if move then
		self.leftkey = false
		self:setScale(1)
	else
		self.speed.x = 0
	end

	self:move()
end

function player:moveLeft(move)
	if self.ducking then
		return
	end
	
	self.leftkey = move
	
	if move then
		self.rightkey = false
		self:setScale(-1)
	else
		self.speed.x = 0
	end

	self:move()
end

function player:moveDown(move)
	self.downKey = move
end

function player:move()
	if self.jumping or self.punching or self.onLadder then
		return
	end

	if self.leftkey or self.rightkey then
		self:setState("walk")
	else
		self:setState("idle")
		self.speed.x = 0
	end
end

function player:isMoving()
	return (self.leftkey or self.rightkey)
end

function player:punch(move, force)
	if not self.abilities["punch"] then
		return
	end

	if self.ducking or self.onLadder then
		return
	end

	self.punching = move

	if move then
		self:setState("punch")
	else
		if force then
			self.speed.x = 0
		end
		self:move()
		self.bashTimer = 0.75
	end
end

function player:duck(move)
	if self:isMoving() or self.jumping or self.punching or self.onLadder then
		return
	end

	if move and self.height ~= 8 then
		self:setState("duck")
		self.height = 8
		self.y = self.y + 6
		duckSound:play()
		self.ducking = true
	else
		self:setState("unduck")
	end
end

function player:use(move)
	if self.ducking then
		return
	end

	self.useKey = move
end

function player:setPosition(x, y)
	if type(x) == "string" then
		local object = state:call("findObject", x)

		if not object then
			return
		end

		x, y = object.x, object.y
	end

	self.x = x
	self.y = y
end

function player:die(reason)
	if self.active then
		entity.die(self, reason)

		self:addHealth(-1, reason)
		self:setState("dead")
		self.freeze = true
		self.active = false
	end
end

function player:unlock()
	entity.unlock(self)

	self.gravity = 360
	self:setState("idle")
	self:setSpeed(0, 0)
end

function player:addHealth(value, reason)
	if value < 0 then
		if reason ~= "spikes" then
			if not self.invincible then
				self.invincible = true
			else
				return
			end
		end

		if self.ducking then
			return
		end
	else
		healthSound:play()
	end

	self.health = math.max(0, math.min(self.health + value, self.maxHealth))

	if self.health == 0 then
		self.freeze = true
		self.active = true
		self.invincible = false
		self.invincibleTimer = 0
		
		state:change("gameover")
	end
end

function player:addMaxHealth()
	self.maxHealth = self.maxHealth + 1
	self:addHealth(self.maxHealth)
end

function player:setHealth(maxHealth)
	if self.health > maxHealth then
		self.health = maxHealth
	end
	self.maxHealth = maxHealth
end

function player:addMoney(value)
	self.money = math.max(0, math.min(self.money + value, 99)) --some stupid limit
end

function player:jump(force)
	if (not self.jumping and not self.onLadder and self.speed.y == 0) or force then
		self.onCrate = false
		if not self.ducking and not self.punching then
			self:setState("jump")
		end
		self.speed.y = -JUMPFORCE - (math.abs(self.speed.x) / 80) * JUMPFORCEADD * 0.5
		jumpSound:play()
		self.jumping = true
	end
end

function player:getAbility(name)
	if not self.abilities[name] then
		self.abilities[name] = true
	end
end

function player:getShell(id)
	self.inventory.items[id].unlocked = true
end

function player:getYOffset()
	local offset = 6
	if self.ducking then
		offset = 12
	end

	return offset
end