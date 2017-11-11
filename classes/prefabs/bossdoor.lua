bossdoor = class("bossdoor")

local bossDoorImage = love.graphics.newImage("graphics/game/door.png")
local bossDoorQuads = {}
local limit = 12

for y = 1, 2 do
	if y == 2 then
		limit = 7
	end
	for x = 1, limit do
		table.insert(bossDoorQuads, love.graphics.newQuad((x - 1) * 32, (y - 1) * 32, 32, 32, bossDoorImage:getWidth(), bossDoorImage:getHeight()))
	end
end

function bossdoor:init(x, y, properties)
	self.x = x
	self.y = y

	self.width = 32
	self.height = 32

	self.locked = true

	self.timer = 0
	self.quadi = 1

	if properties.link then
		self.link = properties.link:split(";")

		self.use = userectangle:new(self.x, self.y, self.width, self.height, function()
			gameFadeOut = true
		end)
	end
end

function bossdoor:update(dt)
	local offset, limit = 0, 13

	local ret = checkrectangle(self.x, self.y, self.width, self.height, {"player"})
	
	if #ret > 0 and ret[1][2].key then
		self.locked = false
		ret[1][2].key = nil
	end

	if not self.locked then
		if not self.done then
			if self.quadi == 13 then
				self.done = true
			end
		else
			offset, limit = 13, 6
		end

		self.timer = self.timer + 8 * dt
		self.quadi = offset + math.floor(self.timer % limit) + 1

		if gameFade == 1 then
			SPAWN_X, SPAWN_Y = tonumber(self.link[2]), tonumber(self.link[3])
			gameInit(self.link[1])
		end

		if self.use then
			self.use:update(dt)
		end
	end
end

function bossdoor:draw()
	love.graphics.draw(bossDoorImage, bossDoorQuads[self.quadi], self.x, self.y)

	if not self.locked then
		if self.use then
			self.use:draw()
		end
	end
end