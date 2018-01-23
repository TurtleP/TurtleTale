bed = class("bed")

local bedImage = love.graphics.newImage("graphics/game/prefabs/bed.png")
local bedQuads = {}
for i = 1, 5 do
	bedQuads[i] = love.graphics.newQuad(0, (i - 1) * 17, 32, 17, bedImage:getWidth(), bedImage:getHeight())
end

function bed:initialize(layer, x, y, properties)
	self.x = x
	self.y = y

	self.width = 32
	self.height = 17

	local scale = 1
	if properties.scale then
		scale = properties.scale
	end

	self.scale = scale

	self.timer = 0
	self.quadi = 1

	self.used = false

	self.useRectangle = userectangle:new(self.x, self.y, self.width, self.height, function(player)
		self.used = not self.used
		player.active = not self.used
		player.freeze = self.used
		player.scale = self.scale
	
		if not self.used then
			self.timer = 0
			self.quadi = 1
		end

		player:use(false)
	end, true)

	self.active = true
	self.static = true

	local offsetX = 0
	if self.scale < 0 then
		offsetX = self.width
	end
	self.offsetX = offsetX

	table.insert(layer, self)
end

function bed:update(dt)
	self.useRectangle:update(dt)

	if self.used then
		self.timer = self.timer + 1.5 * dt
		self.quadi = 1 + math.floor(self.timer % 4) + 1
	end
end

function bed:draw()
	self.useRectangle:draw()
	love.graphics.draw(bedImage, bedQuads[self.quadi], self.x, self.y, 0, self.scale, 1, self.offsetX)

	if self.used and math.floor(self.timer) % 2 == 0 then
		love.graphics.print("z", self.x + 14, self.y - 12)
	end
end