hitbox = class("hitbox")

function hitbox:initialize(x, y, width, height, filter, ...)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	local objectList = checkrectangle(x, y, width, height, filter)
	local args = {...}

	print(#objectList, args[1], args[2])
	if #objectList > 0 then
		local object = objectList[1] 
		if object[args[1]] then
			print("!")
			object[args[1]](object, unpack(args[2]))
		end
	end
end