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
	self.scale = scale
end

function object:getXOffset()
	local offset = 0
	if self.scale < 0 then
		offset = self.width
	end
	
	return offset
end

function object:checkDeath(dt)
	local check = checkrectangle(self.x, self.y, self.width, self.height, {"water"})

	if #check > 0 then
		if check[1] then
			check[1]:splash(self)
		end
	end

	if self.y > SCREEN_HEIGHT then
		if tostring(self) ~= "player" then
			self:die("pit")
		else
			self:setState("dead")
		end
	end
end

function object:unlock()
	self.freeze = false
	self.active = true
end

function object:die(reason)
	self.remove = true
	if reason == "pit" then
		return false
	end
	return true
end

local oldString = object.__tostring
function object:__tostring()
	return oldString(self):gsub("instance of class ", "")
end