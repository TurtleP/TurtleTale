entity = class("entity")

function entity:init(x, y)
	self.originX = x
	self.originY = y

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
	self.speaking = false

	self.health = 1

	self.invincible = false
	self.invincibleTimer = 0
end

function entity:updateDirection(dt)
	if self.speedx > 0 then
		self:setDirection(-math.abs(self.scale))
	elseif self.speedx < 0 then
		self:setDirection(math.abs(self.scale))
	end
end

function entity:isInvincible()
	return self.invincible
end

function entity:getHealth()
	return self.health
end

function entity:speak(text)
	if objects["player"] then
		if objects["player"][1].scale ~= self.scale then
			if objects["player"][1].x < self.x then
				self:setDirection(1)
			else
				self:setDirection(-1)
			end
		end
	end
	self.speaking = true
	gameNewDialog(self.entity, text, true)
end

function entity:equals(compare)
	return compare == self.entity
end

function entity:getOffset()
	if self.scale > 0 then
		return self.offsets[1]
	end
	return self.offsets[2]
end

function entity:setDirection(dir)
	if self.scale ~= dir then
		self.scale = dir
	end
end

function entity:getPunched(dir)
	if not self.punched then
		self.speedx = turtlePunchForce * dir
		self.speedy = -96
		punchSound:play()
		self.punched = true
	end
end

function entity:isPunched()
	return self.punched
end

function entity:addLife()
	self.health = math.max(self.health - 1, 0)
end

function entity:getPosition()
	return self.x, self.y
end

function entity:die(t)
	if self.health ~= 0 then
		if t == true or t == "stop" then
			self.speedx = 0
			self.speedy = 0
		end
		self.punched = false
		return
	end

	table.insert(smokes, smoke:new(self.x + self.width / 2 - 12, self.y + self.height - 24))
	if objects["player"][1]:hasLowHealth() then
		if math.random(100) < 30 then
			table.insert(objects["health"], health:new(self.x + (self.width - 6) / 2, self.y))
		end
	end

	poofSound:play()

	table.insert(MAP_DATA[tiled:getMapName()], {self.originX, self.originY, false})

	self.remove = true
end