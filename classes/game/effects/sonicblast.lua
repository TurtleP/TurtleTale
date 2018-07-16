sonicblast = class("sonicblast", object)

local sonicBlastImage = love.graphics.newImage("graphics/game/effects/sonicwave.png")
local sonicBlastQuads = {}
for i = 1, 4 do
	sonicBlastQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, sonicBlastImage:getWidth(), sonicBlastImage:getHeight())
end

local echoSound = love.audio.newSource("audio/echo.ogg", "static")

function sonicblast:initialize(x, y, speed)
	object.initialize(self, x, y, 16, 16)

	self.speed = speed

	if speed.x < 0 then
		self.scale = -1
	end

	self.category = 4

	self.timer = 0
	self.quadi = 1

	local layers = state:get("layers")
	table.insert(layers[1], self)

	echoSound:play()
end

function sonicblast:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #sonicBlastQuads) + 1
end

function sonicblast:draw()
	love.graphics.draw(sonicBlastImage, sonicBlastQuads[self.quadi], self.x, self.y, 0, self.scale, 1, self:getXOffset())
end