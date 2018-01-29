key = class("key", object)

local keyImage = love.graphics.newImage("graphics/game/key.png")
local keyQuads = {}
for i = 1, 6 do
	keyQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, keyImage:getWidth(), keyImage:getHeight())
end

local keySound = love.audio.newSource("audio/key.ogg", "static")

function key:initialize(x, y)
	object.initialize(self, x, y, 16, 10)

	self.quadi = 1
	self.timer = 0

	local layers = state:get("layers")
	table.insert(layers[2], self)
end

function key:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #keyQuads) + 1

	local ret = checkrectangle(self.x, self.y, self.width, self.height, {"player"})
	if #ret > 0 then
		local display = state:get("display")
		display:addToInventory(tostring(self))
		keySound:play()
		self.remove = true
	end
end

function key:draw()
	love.graphics.draw(keyImage, keyQuads[self.quadi], self.x, self.y, 0, self.scale, 1, self:getXOffset())
end