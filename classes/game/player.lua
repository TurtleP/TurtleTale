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

function player:initialize(x, y)
	entity.initialize(self, nil, x, y, 12, 14)

	self.category = 2
	self.gravity = 360

	self.mask = { true }
	self.money = 0
	
	self.maxHealth = 3
	self.health = self.maxHealth

	self.abilities = 
	{
		["punch"] = true
	}

	self.quadi = 1
	self.state = "idle"

	self.timer = 0

	self.jumping = false
	self.rightkey = false
	self.leftkey = false
	self.ducking = false

	self.punching = false

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
		climb = {rate = 6, stop = false},
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

	if not self.punching then
		if self.speed.y > 0 then
			self:changeState("jump")
		end
	end
end

function player:draw()
	love.graphics.draw(turtleImage, turtleQuads[self.state][self.quadi], self.x + self:getXOffset(), self.y - self:getYOffset(), 0, self.scale, 1)
end

function player:downCollide(name, data)
	if name == "tile" then
		if self.jumping or self.state == "jump" then
			self.jumping = false
			self:move()
		end
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

	if self.ducking then
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
		self.ducking = true
	else
		self:changeState("unduck")
	end
end

function player:setPosition(x, y)
	self.x = x
	self.y = y
end

function player:jump()
	if not self.jumping then
		if not self.ducking and not self.punching then
			self:changeState("jump")
		end
		self.speed.y = -JUMPFORCE - (math.abs(self.speed.x) / 80) * JUMPFORCEADD * 0.5
		self.jumping = true
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