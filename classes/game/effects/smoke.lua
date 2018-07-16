smoke = class("smoke")

local smokeImage = love.graphics.newImage("graphics/game/effects/smoke.png")
local smokeQuads = {}
for y = 1, 3 do
	for x = 1, 4 do
		table.insert(smokeQuads, love.graphics.newQuad((x - 1) * 24, (y - 1) * 24, 24, 24, smokeImage:getWidth(), smokeImage:getHeight()))
	end
end

local deathSound = love.audio.newSource("audio/poof.ogg", "static")

function smoke:initialize(x, y, offset)
	self.x = x
	self.y = y

	self.timer = 0
	self.quadi = 1

	self.active = true
	self.static = true

	deathSound:play()

	self.offset = offset or 0

	local layers = state:get("layers")
	table.insert(layers[2], self)
end

function smoke:update(dt)
	if self.quadi < #smokeQuads then
		self.timer = self.timer + 9 * dt
		self.quadi = self.offset + math.floor(self.timer % #smokeQuads) + 1
	else
		self.remove = true
	end
end

function smoke:draw()
	love.graphics.draw(smokeImage, smokeQuads[self.quadi], self.x, self.y)
end