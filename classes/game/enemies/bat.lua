bat = class("bat", entity)

local batImage = love.graphics.newImage("graphics/game/enemies/bat.png")
local batStates = { {"idle", 4}, {"drop", 3}, {"fly", 3} }
local batQuads = {}
for y = 1, 3 do
	batQuads[batStates[y][1]] = {}
	for x = 1, batStates[y][2] do
		table.insert(batQuads[batStates[y][1]], love.graphics.newQuad((x - 1) * 16, (y - 1) * 16, 16, 16, batImage:getWidth(), batImage:getHeight()))
	end
end

function bat:initialize(layer, x, y, state)
	entity.initialize(self, layer, x, y, 16, 16)

	self.category = 5

	self.mask = { false }

	self.animationRules =
	{
		idle = {stop = true, condition = function()
			return self.idleTimer == 0
		end, func = function()
			self.quadi = 1
			self.timer = 0
			self.idleTimer = math.random(2, 3)
		end},
		drop = {stop = true, func = function()
			self:setState("fly")
		end},
		fly = {stop = false}
	}

	self.state = state or "idle"

	self.timer = 0
	self.quadi = 1

	self.idleTimer = math.random(2, 3)
	self.squeakTimer = math.random(1, 2)

	self.moveSpeed = math.random(64, 72)
end

function bat:animate(dt)
	self:checkDeath(dt)
	self:checkSplash()

	if self.animationRules[self.state] then
		local rule = self.animationRules[self.state]

		if rule.condition then
			if not rule.condition() then
				return
			end
		end
		
		if self.quadi == #batQuads[self.state] and rule.stop then
			if rule.func then
				rule.func()
			end
			return
		end
	end

	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #batQuads[self.state]) + 1
end

function bat:update(dt)
	self:animate(dt)

	self:checkDeath()
	
	local player = state:get("player")

	if player.x > self.x then
		self:setScale(1)
	else
		self:setScale(-1)
	end

	if self.state == "idle" then
		if distance(player.x, player.y, self.x, self.y) <= 64 then
			self:setState("drop")
		end

		self.idleTimer = math.max(self.idleTimer - dt, 0)
	end

	self.squeakTimer = self.squeakTimer - dt
	if self.squeakTimer < 0 then
	--	batIdleSound[math.random(#batIdleSound)]:play()
		self.squeakTimer = math.random(1, 2)
	end

	if self.state == "fly" then
		local angle = math.atan2(player.y - self.y, player.x - self.x)

		self.speed.x = math.cos(angle) * self.moveSpeed
		self.speed.y = math.sin(angle) * self.moveSpeed

		self.squeakTimer = self.squeakTimer - dt
		if self.squeakTimer < 0 then
			--batChaseSound:play()
			self.squeakTimer = math.random(1, 2)
		end
	end
end

function bat:draw()
	love.graphics.draw(batImage, batQuads[self.state][self.quadi], self.x, self.y, 0, self.scale, 1, self:getXOffset())
end

function bat:punch(dir)
	self:die()
end