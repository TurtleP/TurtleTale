hermit = class("hermit", ai)

local hermitImage = love.graphics.newImage("graphics/game/enemies/hermit.png")
local hermitQuads = {}
local hermitStates = {{"walk", 4}, {"idle", 4}, {"attack", 8}}
for y = 1, 3 do
	hermitQuads[hermitStates[y][1]] = {}
	for x = 1, hermitStates[y][2] do
		table.insert(hermitQuads[hermitStates[y][1]], love.graphics.newQuad((x - 1) * 16, (y - 1) * 16, 16, 16, hermitImage:getWidth(), hermitImage:getHeight()))
	end
end

function hermit:init(x, y, properties)
	ai.init(self, x, y)

	self.x = x
	self.y = y

	self.width = 12
	self.height = 12

	self.mask =
	{
		true, true, true
	}

	self.quadi = 1
	self.timer = 0

	self.active = true

	self.gravity = 480

	self.speedx = 0
	self.speedy = 0

	self.scale = -1
	self.offsets = {0, 14}

	self.dialog = properties.speak
	self.render = false
end

function hermit:update(dt)
	if self.dialog then
		local ret = checkrectangle(self.x + 4, self.y, self.width - 8, self.height, {"player"}, self)

		self.render = #ret > 0

		if not self.render then
			return
		else
			if ret[1][2].useKey then
				self:speak(self.dialog)
			end
		end
	end

	ai.passiveThink(self, dt)

	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #hermitQuads[self.state]) + 1
end

function hermit:draw()
	love.graphics.draw(hermitImage, hermitQuads[self.state][self.quadi], self.x + self:getOffset(), self.y - 4, 0, self.scale, 1)

	if not self.render then
		return
	end

	love.graphics.setColor(0, 0, 0)
	love.graphics.draw(selectionVerImage, selectionVerQuads[self.quadi], (self.x + (self.width / 2)) - 6, (self.y - 19) + math.sin(love.timer.getTime() * 4))

	love.graphics.setColor(255, 0, 0)
	love.graphics.draw(selectionVerImage, selectionVerQuads[self.quadi], (self.x + (self.width / 2)) - 5, (self.y - 18) + math.sin(love.timer.getTime() * 4))

	love.graphics.setColor(255, 255, 255)
end