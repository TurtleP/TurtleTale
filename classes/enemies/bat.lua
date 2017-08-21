bat = class("bat", ai)

local batImage = love.graphics.newImage("graphics/game/enemies/bat.png")
local batStates = { {"idle", 3}, {"drop", 3}, {"fly", 3} }
local batQuads = {}
for y = 1, 3 do
	batQuads[batStates[y][1]] = {}
	for x = 1, batStates[y][2] do
		table.insert(batQuads[batStates[y][1]], love.graphics.newQuad((x - 1) * 16, (y - 1) * 16, 16, 16, batImage:getWidth(), batImage:getHeight()))
	end
end

function bat:init(x, y)
	ai.init(self, x, y)

	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.mask = { false, true }

	self.active = true
	
	self.category = 8
	self.state = "idle"

	self.speedx = 0
	self.speedy = 0

	self.offsets = {0, self.width}
	self.scale = 1

	self.gravity = 0

	self.timer = 0
	self.quadi = 2

	self.idleTimer = math.random(2, 3)
	self.idleAnim = {2, 3, 2, 1}
	self.squeakTimer = math.random(1, 2)
end

function bat:update(dt)
	if self.punched then
		return
	end

	ai.update(self, dt)

	if self.state == "idle" then
		self.idleTimer = self.idleTimer - dt
		local i = 2
		if self.idleTimer < 0 then
			self.timer = self.timer + 6 * dt
			i = math.floor(self.timer % #self.idleAnim + 1) + 1

			if i <= #self.idleAnim then
				self.quadi = self.idleAnim[i]
			else
				self.timer = 0
				self.quadi = 2
				self.idleTimer = math.random(2, 3)
			end
		end

		self.squeakTimer = self.squeakTimer - dt
		if self.squeakTimer < 0 then
			batIdleSound[math.random(#batIdleSound)]:play()
			self.squeakTimer = math.random(1, 2)
		end
	else
		self.timer = self.timer + 6 * dt
		self.quadi = math.floor(self.timer % #batQuads[self.state]) + 1
	end

	if self.state == "idle" then
		if objects["player"][1].y < self.y then
			return
		end

		if util.dist(objects["player"][1].x, objects["player"][1].y, self.x, self.y) < 64 then
			self.timer = 0
			self.quadi = 1
			self.state = "drop"
		end
	end

	if self.state == "drop" then
		if self.quadi == #batQuads["drop"] then
			self.gravity = 0
			self.state = "fly"
			self.squeakTimer = math.random(1, 2)
		end
	end

	if self.state == "fly" then
		local angle = math.atan2(objects["player"][1].y - self.y, objects["player"][1].x - self.x)

		self.speedx = math.cos(angle) * 64
		self.speedy = math.sin(angle) * 64

		self.squeakTimer = self.squeakTimer - dt
		if self.squeakTimer < 0 then
			batChaseSound:play()
			self.squeakTimer = math.random(1, 2)
		end
	end
end

function bat:draw()
	love.graphics.draw(batImage, batQuads[self.state][self.quadi], self.x + self:getOffset(), self.y, 0, self.scale)
end

function bat:getPunched(dir)
	ai.getPunched(self, dir)

	self.mask[1] = true
	self.gravity = 480
end