health = class("health", entity)

local healthImage = love.graphics.newImage("graphics/game/health.png")
local healthQuads = {}
for i = 1, 8 do
	healthQuads[i] = love.graphics.newQuad((i - 1) * 13, 0, 13, 8, healthImage:getWidth(), healthImage:getHeight())
end

function health:init(x, y)
	entity.init(self, x, y)

	self.x = x
	self.y = y

	self.width = 13
	self.height = 8

	self.active = true

	self.gravity = 480
	
	self.speedx = 0
	self.speedy = 0

	self.scale = 1

	self.offsets = {0, self.width}

	self.timer = 0
	self.quadi = 1

	self.jumpTimer = math.random(1, 2)

	self.mask = { true }

	self.category = 7
	self.simpleFlips = false
end

function health:update(dt)
	self.jumpTimer = self.jumpTimer - dt
	if self.jumpTimer < 0 then
		self:jump()
		self.jumpTimer = math.random(1, 2)
	end

	self.timer = self.timer + 9 * dt
	self.quadi = math.floor(self.timer % #healthQuads) + 1

	if self.speedy ~= 0 then
		if not self.simpleFlips then
			if math.random() == 0 then
				self.scale = -1
			end
			self.simpleFlips = true
		end
	end

	print(self.quadi)
end

function health:draw()
	love.graphics.draw(healthImage, healthQuads[self.quadi], self.x + self:getOffset(), self.y, 0, self.scale)
end

function health:jump()
	if self.speedy == 0 then
		self.speedy = -104
		self.simpleFlips = false
	end
end

function health:collect(turtle)
	turtle:addLife(1)
	self.remove = true
end