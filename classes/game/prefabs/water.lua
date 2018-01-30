water = class("water", object)

local waterImage = love.graphics.newImage("graphics/game/objects/water.png")
local waterQuads = {}
for i = 1, 7 do
	waterQuads[i] = love.graphics.newQuad((i - 1) * 17, 0, 16, 16, waterImage:getWidth(), waterImage:getHeight())
end

function water:initialize(layer, x, y, width, height)
	object.initialize(self, x, y, width, height)

	self.timer = 0
	self.quadi = 1

	self.static = true

	self.layer = layer
	
	--drown these
	self.filter =
	{
		"player",
		"hermit",
		"bat",
		"spider",
		"health",
		"money"
	}
	
	self.fire = false

	table.insert(layer, self)
end

function water:update(dt)
	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % 6) + 1
end

function water:splash(object)
	if object.y + object.height / 2 > self.y and object.speed.y > 0 and not self.fire then
		local pass = false
		for i = 1, #self.filter do
			if tostring(object) ~= self.filter[i] then
				pass = true
			end
		end

		if pass then
			particle:new(self.layer, object.x, self.y, vector(-40, -64), {58, 94, 101})
			particle:new(self.layer, object.x, self.y, vector(40, -64), {58, 94, 101})
			self.fire = true
		end
	else
		self.fire = false
	end
end

function water:draw()
	for x = 1, self.width / 16 do
		love.graphics.draw(waterImage, waterQuads[self.quadi], self.x + (x - 1) * 16, self.y)
		for y = 2, self.height / 16 do
			love.graphics.draw(waterImage, waterQuads[7], self.x + (x - 1) * 16, self.y + (y - 1) * 16)
		end
	end
end