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

	local evil = false
	if properties then
		self.dialog = properties.speak
		self.use = userectangle:new(self.x - 16, self.y, 16, 16, function()
			if #dialogs == 0 then
				self:speak(self.dialog)
			end
		end, true)

		evil = properties.evil
		
		if properties.checkGaps ~= nil then
			if not properties.checkGaps then
				self.checkGaps = function(self)
					--cheat the system
				end
			end
		end
	end
	
	self.render = false
	self.evil = evil

	self.graphic = hermitImage
	self.quad = hermitQuads
end

function hermit:update(dt)
	if self.dialog then
		self.use:update(dt)

		local x = self.x - 16
		if self.scale == 1 then
			x = self.x + self.width + 16
		end
		self.use:setPosition(x, self.y)
	end

	if not self.speaking then
		if #dialogs == 0 then
			ai.passiveThink(self, dt)
		end
	else
		self.speaking = false
		self.speedx = 0
		self.speedy = 0
	end

	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #hermitQuads[self.state]) + 1
end

function hermit:draw()
	love.graphics.draw(hermitImage, hermitQuads[self.state][self.quadi], self.x + self:getOffset(), self.y - 4, 0, self.scale, 1)

	self.use:draw()
end

function hermit:getPunched(dir)
	ai.getPunched(self, dir)
	
	self:addLife(-1)
end