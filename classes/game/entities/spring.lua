spring = class("spring", entity)

local springImage = love.graphics.newImage("graphics/game/objects/spring.png")
local springQuads = {}
for i = 1, 4 do
	springQuads[i] = love.graphics.newQuad((i - 1) * 17, 0, 16, 16, springImage:getWidth(), springImage:getHeight())
end

function spring:initialize(layer, x, y, properties)
	entity.initialize(self, layer, x, y, 16, 16)

	for k, v in pairs(properties) do
		if type(k) == "string" then
			self[k] = v
		end
	end

	self.category = 1

	self.timer = 0
	self.quadi = 1
end

function spring:update(dt)
	if self.bouncing then
		if self.quadi < #springQuads then
			self.timer = self.timer + 12 * dt
			self.quadi = math.floor(self.timer % #springQuads) + 1
		else
			self.timer = 0
			self.quadi = 1

			self.bouncing = false
		end
	end
end

function spring:draw()
	love.graphics.draw(springImage, springQuads[self.quadi], self.x, self.y)
end

function spring:bounce()
	if not self.bouncing then
		self.bouncing = true
	end
end