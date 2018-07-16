object = class("object")

function object:initialize(x, y, width, height)
	self.x = x
	self.y = y

	self.origin = vector(x, y)

	self.width = width
	self.height = height

	self.speed = vector(0, 0)
	self.active = true

	self.gravity = 0

	self.scale = 1
end

function object:setScale(scale)
	if not paused then
		self.scale = scale
	end
end

function object:getXOffset()
	local offset = 0
	if self.scale < 0 then
		offset = self.width
	end
	
	return offset
end

function object:checkSplash()
	local check = checkrectangle(self.x, self.y, self.width, self.height, {"water"})

	if #check > 0 then
		if check[1] then
			return check[1]:splash(self)
		end
	end
end

function object:setSpeed(x, y)
	local speed = vector(x, y)
	self.speed = speed
end

function object:setSpeedX(velocityX)
	self.speed.x = velocityX
end

function object:setSpeedY(velocityY)
	self.speed.y = velocityY
end

function object:checkDeath(dt)
	local height = SCREEN_HEIGHT
	if state:get("map") ~= nil then
		height = state:get("map").height
	end

	if self.y > height then
		if tostring(self) ~= "player" then
			self:die("pit")
		else
			self:setState("dead")
			self:addHealth(-1)
		end
	end
end

function object:unlock()
	self.freeze = false
	self.active = true
end

function object:die(reason)
	self:addToFix()
	self.remove = true
	if reason == "pit" then
		return false
	end
	return true
end

function object:addToFix(shouldSave)
	if not shouldSave then
		shouldSave = false
	end
	state:call("addFixData", self, shouldSave)
end

-- called only when loading a map 
-- with enemies that died n stuff
function object:fix() 
	self.remove = true
end

local oldString = object.__tostring
function object:__tostring()
	return oldString(self):gsub("instance of class ", "")
end