coin = class("coin", entity)

shellImage = love.graphics.newImage("graphics/game/shell.png")
shellQuads = {}
for i = 1, 2 do
	shellQuads[i] = love.graphics.newQuad((i - 1) * 7, 0, 7, 6, shellImage:getWidth(), shellImage:getHeight())
end
table.insert(shellQuads, love.graphics.newQuad(0, 7, 15, 9, shellImage:getWidth(), shellImage:getHeight()))

local sparkleImage = love.graphics.newImage("graphics/game/sparkle.png")
local sparkleQuads = {}
for i = 1, 8 do
	sparkleQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, sparkleImage:getWidth(), sparkleImage:getHeight())
end

function coin:init(x, y, c)
	entity.init(self, x, y)

	self.width = 6
	self.height = 6

	local cost = c or 1

	if cost ~= 10 then
		if math.random() < .2 then
			cost = 5
		end
	end

	self.cost = cost

	self.timer = 0
	self.quadi = 1

	self.mask = { true }

	self.category = 7
	self.delay = math.random(1, 2)

	self.costi = 1
	if cost == 5 then
		self.costi = 2
	elseif cost == 10 then
		self.costi = 3

		self.width = 15
		self.height = 10
	end

	self.active = true
	self.gravity = 400

	self.speedx = 0
	self.speedy = 0
end

function coin:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #sparkleQuads) + 1
end

function coin:draw()
	love.graphics.draw(shellImage, shellQuads[self.costi], self.x, self.y)

	love.graphics.draw(sparkleImage, sparkleQuads[self.quadi], self.x + (self.width / 2) - 8, self.y + self.height / 2 - 8)
end

function coin:collect(turtle)
	if not self.remove then
		turtle:addMoney(self.cost)
		coinPickupSound:play()
		self.remove = true
	end
end

function coin:downCollide(name)
	if name == "tile" then
		self.speedy = -self.speedy * 0.5
	end
end