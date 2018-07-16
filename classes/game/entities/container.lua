container = class("container", object)

local containerImage = love.graphics.newImage("graphics/game/objects/container.png")
local containerQuads = {}
for i = 1, 6 do
	containerQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 14, containerImage:getWidth(), containerImage:getHeight())
end

function container:initialize(x, y)
	object.initialize(self, x, y, 16, 16)

	self.timer = 0
	self.quadi = 1

	self.gravity = 0
	self.speed.y = 50

	self.mask = { true }

	self.category = 4

	local layer = state:get("layers")
	table.insert(layer[3], self)
end

function container:update(dt)
	self.timer = self.timer + 10 * dt
	self.quadi = math.floor(self.timer % #containerQuads) + 1
end

function container:draw()
	love.graphics.draw(containerImage, containerQuads[self.quadi], self.x, self.y + math.sin(love.timer.getTime() * 4))
end

function container:collect(player)
	if player.speed.y ~= 0 then
		return
	end

	event:load("container", CUTSCENES["container"][1])

	self.speed = vector(0, 0)
	self.gravity = 0
	self.y = player.y - (self.height + 6)
	self.x = player.x + player:getXOffset()
end