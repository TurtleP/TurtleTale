phoenix = class("phoenix", entity)

local phoenixImage = love.graphics.newImage("graphics/game/enemies/phoenix.png")
local phoenixQuads = {}
for y = 1, 3 do
	for x = 1, 3 do
		table.insert(phoenixQuads, love.graphics.newQuad((x - 1) * 77, (y - 1) * 50, 77, 50, phoenixImage:getWidth(), phoenixImage:getHeight()))
	end
end

function phoenix:initialize(layer, x, y)
	entity.initialize(self, layer, x, y, 77, 50)
	
	self.state = "idle"

	self.animations =
	{
		["idle"] = {rate = 0, anim = {6}},
		["flight"] = {rate = 8, anim = {1, 2, 3, 2}},
		["glide"] = {rate = 2, anim = {4, 5}}
	}

	self.timer = 0
	self.quadi = 1

	self.fireballTime = 0
	self.fireballThrow = false
	self.fireballDirection = "right"
	self.fireballDelay = 0

	self.offset = 0

	self.layer = layer
end

function phoenix:update(dt)
	self.timer = self.timer + self.animations[self.state].rate * dt
	self.quadi = self.animations[self.state].anim[math.floor(self.timer % #self.animations[self.state].anim) + 1]

	if self.state == "flight" then
		self.offset = math.sin(love.timer.getTime() * 6) * 4
	end

end

function phoenix:draw()
	love.graphics.draw(phoenixImage, phoenixQuads[self.quadi], self.x, self.y + self.offset, 0, self.scale, 1, self:getXOffset())
end

function phoenix:fireball(target)
	self.fireballDirection = direction
	fire:new(state:get("layers")[2], self.x, self.y + 16 + self.offset, vector(-200, 200))
end