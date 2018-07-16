hitbox = class("hitbox")

function hitbox:initialize(x, y, width, height, filter, ...)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	local objectList = checkrectangle(x, y, width, height, filter)
	local args = {...}

	if #objectList > 0 then
		local object = objectList[1] 
		if object[args[1]] then
			object[args[1]](object, unpack(args[2]))

			if args[3] then --callback function
				args[3]()
			end
		end
	end
end