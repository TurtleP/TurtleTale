hermit = class("hermit", entity)

local hermitImage = love.graphics.newImage("graphics/game/enemies/hermit.png")
local hermitQuads = {}
local hermitStates = {{"idle", 4}, {"walk", 4}, {"attack", 8}}
for y = 1, 3 do
	hermitQuads[hermitStates[y][1]] = {}
	for x = 1, hermitStates[y][2] do
		table.insert(hermitQuads[hermitStates[y][1]], love.graphics.newQuad((x - 1) * 16, (y - 1) * 16, 16, 16, hermitImage:getWidth(), hermitImage:getHeight()))
	end
end

function hermit:initialize(layer, x, y, properties)
	entity.initialize(self, layer, x, y, 16, 16)

	self.category = 3

	self.mask = { true, false, false }

	self.timer = 0
	self.quadi = 1

	self.gravity = 480

	self.active = true

	self.state = "idle"

	self.idleTime = math.random(1, 2)
	self.walkTime = math.random(2, 4)

	if next(properties) then
		for k, v in pairs(properties) do
			self[k] = v
		end
	end

	self.useRectangle = userectangle:new(self.x, self.y, self.width, self.height, function(player)
		if player.scale == -self.scale then
			if not self.dialog and self.speak then
				self.freeze = true
				player.freeze = true

				self:setState("idle")
				self:setSpeed(0, 0)

				self:talk(self.speak)
			end
		end
	end, true, false, nil, function(player)
		return not player.freeze
	end)

	

	self.graphic = hermitImage
	self.quads = hermitQuads
end

function hermit:animate(dt)
	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #hermitQuads[self.state]) + 1
end

function hermit:update(dt)
	self:animate(dt)

	if self.freeze then
		if self.dialog then
			if self.dialog.remove then
				if not event:isRunning() then
					state:get("player").freeze = false
					self.freeze = false
				end
				self.dialog = nil
			end
		end
		return
	else
		self.useRectangle:setPosition(self.x + (16 * self.scale), self.y)
		self.useRectangle:update(dt)
	end

	if self.walkTime > 0 then
		self.walkTime = self.walkTime - dt
		self.speed.x = 32 * self.scale
	else
		self.speed.x = 0
		if self.idleTime > 0 then
			self.idleTime = self.idleTime - dt
		else
			self.idleTime = math.random(1, 2)
			self.walkTime = math.random(2, 4)
		end
	end

	if self.speed.x ~= 0 then
		self:setState("walk")
	else
		self:setState("idle")
	end
end

function hermit:draw()
	love.graphics.draw(hermitImage, hermitQuads[self.state][self.quadi], self.x, self.y, 0, self.scale, 1, self:getXOffset())
end

function hermit:setState(state)
	if state ~= self.state then
		self.quadi = 1
		self.timer = 0
		self.state = state
	end
end

function hermit:rightCollide(name, data)
	if name == "tile" or name == "barrier" then
		self.speed.x = -self.speed.x
		self:setScale(-self.scale)
	end
end

function hermit:leftCollide(name, data)
	if name == "tile" or name == "barrier" then
		self.speed.x = -self.speed.x
		self:setScale(-self.scale)
	end
end