smoke = class("smoke") --repurpose for smoke kthx, 24x24

local smokeImage = love.graphics.newImage("graphics/game/smoke.png")
local smokeQuads = {}
for y = 1, 3 do
	for x = 1, 4 do
		table.insert(smokeQuads, love.graphics.newQuad((x - 1) * 24, (y - 1) * 24, 24, 24, smokeImage:getWidth(), smokeImage:getHeight()))
	end
end

function smoke:init(x, y)
	self.x = x
	self.y = y

	self.timer = 0
	self.quadi = 1

	poofSound:play()
end

function smoke:update(dt)
	if self.quadi < #smokeQuads then
		self.timer = self.timer + 6 * dt
		self.quadi = math.floor(self.timer % #smokeQuads) + 1
	else
		self.remove = true
	end
end

function smoke:draw()
	love.graphics.setColor(255, 255, 255, 180)
	love.graphics.draw(smokeImage, smokeQuads[self.quadi], self.x, self.y)

	love.graphics.setColor(255, 255, 255, 255)
end