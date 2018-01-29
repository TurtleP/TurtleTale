health = class("health", object)

local healthImage = love.graphics.newImage("graphics/game/health.png")
local healthQuads = {}
for i = 1, 8 do
	healthQuads[i] = love.graphics.newQuad((i - 1) * 13, 0, 13, 8, healthImage:getWidth(), healthImage:getHeight())
end

function health:initialize(x, y)
	object.initialize(self, x, y, 13, 8)

	self.timer = 0
	self.quadi = 1

	self.jumpTimer = math.random(1, 2)

	self.category = 4

	self.gravity = 480

	self.mask = { true }

	local layers = state:get("layers")
	table.insert(layers[1], self)
end

function health:update(dt)
	self.jumpTimer = self.jumpTimer - dt
	if self.jumpTimer < 0 then
		self:jump()
		self.jumpTimer = math.random(1, 2)
	end

	self.timer = self.timer + 9 * dt
	self.quadi = math.floor(self.timer % #healthQuads) + 1

	if self.speed.y ~= 0 then
		if not self.simpleFlips then
			if math.random(1) == 0 then
				self:setScale(-self.scale)
			end
			self.simpleFlips = true
		end
	end
end

function health:draw()
	love.graphics.draw(healthImage, healthQuads[self.quadi], self.x + self:getXOffset(), self.y, 0, self.scale)
end

function health:collect(player)
	player:addHealth(1)
	self:die()
end

function health:jump()
	if self.speed.y == 0 then
		self.speed.y = -104
		self.simpleFlips = false
	end
end