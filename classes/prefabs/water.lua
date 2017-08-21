water = class("water")

function water:init(x, y, properties)
	self.x = x
	self.y = y
	
	self.width = properties.width
	self.height = 16

	self.timer = 0
	self.quadi = 1

	if properties.fish then
		self.spawnFishDelay = math.random(1, 3)
	end
end

function water:update(dt)
	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #waterQuads) + 1

	if self.spawnFishDelay then
		self.spawnFishDelay = self.spawnFishDelay - dt
		if self.spawnFishDelay < 0 then
			table.insert(objects["fish"], fish:new(math.random(self.x, self.x + self.width), self.y + self.height - 1, {math.random(-self.width, self.width), -200}))
			self.spawnFishDelay = math.random(1, 3)
		end
	end
end

function water:draw()
	for x = 1, self.width / 16 do
		love.graphics.draw(waterImage, waterQuads[self.quadi], self.x + (x - 1) * 16, self.y)
	end
end