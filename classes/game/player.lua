player = class("player", entity)

local turtleImage = love.graphics.newImage("graphics/game/turtle.png")
local turtleQuads = {}
local turtleAnimations = { {"idle", 4}, {"walk", 4}, {"jump", 3}, {"dead", 6}, {"duck", 6}, {"unduck", 5}, {"spin", 5}, {"punch", 4}, {"climb", 6} }

for y = 1, #turtleAnimations do
	turtleQuads[turtleAnimations[y][1]] = {}
	for x = 1, turtleAnimations[y][2] do
		table.insert(turtleQuads[turtleAnimations[y][1]], love.graphics.newQuad((x - 1) * 12, (y - 1) * 20, 12, 20, turtleImage:getWidth(), turtleImage:getHeight()))
	end
end

function player:initialize(world, x, y)
	entity.initialize(self, world, x, y, 12, 14)

	self.category = 2

	self.money = 0
	
	self.maxHealth = 3
	self.health = self.maxHealth

	self.abilities = {}

	self.quadi = 1
	self.state = "idle"

	self.timer = 0
end

function player:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1
end

function player:draw()
	love.graphics.draw(turtleImage, turtleQuads[self.state][self.quadi], self.x, self.y)
end