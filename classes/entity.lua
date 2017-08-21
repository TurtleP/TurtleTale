entity = class("entity")

function entity:init(x, y)
	self.x = x

	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.mask = {}

	self.state = "idle"

	self.active = true
	self.gravity = 480

	self.speedx = 0
	self.speedy = 0

	self.scale = 1
	self.offsets = {0, 0}

	self.entity = tostring(self.class):gsub("class ", "")
	self.punched = false
end

function entity:update(dt)
	if self.speedx > 0 then
		self:setDirection(-1)
	elseif self.speedx < 0 then
		self:setDirection(1)
	end
end

function entity:speak(text)
	gameNewDialog(self.entity, text)
end

function entity:getOffset()
	if self.scale == 1 then
		return self.offsets[1]
	end
	return self.offsets[2]
end

function entity:setDirection(dir)
	self.scale = dir
end

function entity:getPunched(dir)
	if not self.punched then
		self.speedx = turtlePunchForce * dir
		self.speedy = -96
		punchSound:play()
		self.punched = true
	end
end

function entity:die()
	table.insert(smokes, smoke:new(self.x + self.width / 2 - 12, self.y + self.height - 24))
	if objects["player"][1]:hasLowHealth() then
		if math.random(100) < 30 then
			table.insert(objects["health"], health:new(self.x + (self.width - 6) / 2, self.y + (self.height - 8)))
		end
	end
	self.remove = true
end