player = class("player", entity)

local turtleImage = love.graphics.newImage("graphics/game/turtle.png")
local turtleQuads = {}
local turtleAnimations = { {"idle", 4}, {"walk", 4}, {"jump", 3}, {"dead", 6}, {"duck", 6}, {"unduck", 5}, {"spin", 5}, {"punch", 4}, {"climb", 6} }

for y = 1, #turtleAnimations do
	turtleQuads[turtleAnimations[y][1]] = {}
	for x = 1, turtleAnimations[y][2] do
		table.insert(turtleQuads[turtleAnimations[y][1]], love.graphics.newQuad((x - 1) * 12, (y - 1) * 20, 12, 20, turtleImage:getWidth(), turtleImage:getHeight()))
	end
end

local jumpSound = love.audio.newSource("audio/jump.ogg", "static")
local duckSound = love.audio.newSource("audio/duck.ogg", "static")

function player:initialize(x, y)
	entity.initialize(self, nil, x, y, 12, 14)

	self.category = 3
	self.gravity = 360

	self.mask = { true }
	self.money = 0
	
	self.maxHealth = 3
	self.health = self.maxHealth

	self.abilities = 
	{
		["punch"] = false
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
			self:changeState("idle") 
			self.y = self.y - 6
			self.height = 14 
			self.ducking = false
		end},
		climb = {rate = 6, stop = false, condition = function()
			return self.speed.y ~= 0
		end},
		punch = {rate = 14, stop = false}
	}
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

	local speed = 0
	if not self.punching then
		if not self.ducking then
			if self.rightkey then
				speed = 80
			elseif self.leftkey then
				speed = -80
			end
		end
	else
		speed = 95 * self.scale
	end

	self.speed.x = speed

	if not self.punching and not self.onLadder then
		if self.speed.y > 0 then
			self:changeState("jump")
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
end

function player:draw()
	love.graphics.draw(turtleImage, turtleQuads[self.state][self.quadi], self.x + self:getXOffset(), self.y - self:getYOffset(), 0, self.scale, 1)
end

function player:upCollide(name, data)
	if name == "tile" then
		if data.ladder then
			return false
		end
	end
end

function player:downCollide(name, data)
	if name == "tile" then
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
end

function player:rightCollide(name, data)
	if name == "tile" then
		if data.ladder then
			return false
		end
	end
end

function player:leftCollide(name, data)
	if name == "tile" then
		if data.ladder then
			return false
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

	if not self.onLadder then
		if (self.y + self.height > data.y) or (self.y < data.y) then
			if self.useKey or self.downKey then
				self.onLadder = true
				self.gravity = 0
				self.x = (data.x + data.width / 2) - self.width / 2
				self:changeState("climb")

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
	end
end

function player:moveRight(move)
	if self.ducking then
		return
	end

	self.rightkey = move
	
	if move then
		self.leftkey = false
		self.scale = 1
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
		self.scale = -1
	end

	self:move()
end

function player:moveDown(move)
	self.downKey = move
end

function player:move()
	if self.jumping or self.punching then
		return
	end

	if self.leftkey or self.rightkey then
		self:changeState("walk")
	else
		self:changeState("idle")
	end
end

function player:isMoving()
	return (self.leftkey or self.rightkey)
end

function player:punch(move)
	if not self.abilities["punch"] then
		return
	end

	if self.ducking or self.onLadder then
		return
	end

	self.punching = move

	if move then
		self:changeState("punch")
	else
		self:changeState("idle")
	end
end

function player:duck(move)
	if self:isMoving() or self.jumping or self.punching then
		return
	end

	if move and self.height ~= 8 then
		self:changeState("duck")
		self.height = 8
		self.y = self.y + 6
		duckSound:play()
		self.ducking = true
	else
		self:changeState("unduck")
	end
end

function player:use(move)
	if self.ducking then
		return
	end

	self.useKey = move
end

function player:setPosition(x, y)
	self.x = x
	self.y = y
end

function player:jump()
	if not self.jumping and not self.onLadder then
		if not self.ducking and not self.punching then
			self:changeState("jump")
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

function player:changeState(state)
	if self.state ~= state then
		self.quadi = 1
		self.timer = 0
		self.state = state
	end
end

function player:getYOffset()
	local offset = 6
	if self.ducking then
		offset = 12
	end

	return offset
end