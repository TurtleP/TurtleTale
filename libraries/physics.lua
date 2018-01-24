--[[
	Turtle's Physics Library
	All code is mine.
	(c) 2015 Tiny Turtle Industries
	(Obviously same licensing as the game)
	v1.2
--]]

local floor = math.floor
local abs = math.abs

--[[
	1. Tile
	2. Player
	4. Phoenix/Door? Wat
	5. Crate
	6. AI
	7. Health
--]]

local physWorld, cache = {}, {}
function physics_load(world)
	physWorld = world

	for k, v in ipairs(world) do
		for j, w in ipairs(v) do
			local name = tostring(w):gsub("instance of class ", "")

			table.insert(cache, {name, w})
		end
	end
end

function physicsupdate(dt)
	for layer, tableValue in pairs(physWorld) do
		for layerIndex, objData in pairs(tableValue) do
			if objData.active and not objData.static then
				local hor, ver, objName = false, false, tostring(objData):gsub("instance of class ", "")

				objData.speed.y = math.min(objData.speed.y + objData.gravity * dt, 15 * 60) --add gravity to objects

				if objData.mask and not objData.passive then
					for _, tableValueOther in pairs(physWorld) do
						for _, obj2Data in pairs(tableValueOther) do
							local obj2Name = tostring(obj2Data):gsub("instance of class ", "")

							if objData ~= obj2Data and objData.mask[obj2Data.category] then
								hor, ver = checkCollision(objData, objName, obj2Data, obj2Name, dt)
							end
						end
					end
				end

				if hor == false then
					objData.x = objData.x + objData.speed.x * dt
				end

				if ver == false then
					objData.y = objData.y + objData.speed.y * dt
				end
			end

			if objData.remove then
				table.remove(physWorld[layer], layerIndex)
			end

			if objData.update then
				objData:update(dt)
			end
		end
	end
end

function checkPassive(objData, objName, obj2Data, obj2Name, dt)
	if aabb(objData.x + objData.speed.x * dt, objData.y + objData.speed.y * dt, objData.width, objData.height, obj2Data.x, obj2Data.y, obj2Data.width, obj2Data.height) then
		if objData.passiveCollide then
			objData:passiveCollide(obj2Name, obj2Data)
		end
	end
end

function checkCollision(objData, objName, obj2Data, obj2Name, dt)
	local hor, ver = false, false

	local horX, y = objData.x + objData.speed.x * dt, objData.y
	local x, verY = objData.x, objData.y + objData.speed.y * dt
	local width, height = objData.width, objData.height
	local otherX, otherY, otherWidth, otherHeight = obj2Data.x, obj2Data.y, obj2Data.width, obj2Data.height

	if not obj2Data.passive then
		if aabb(horX, y, width, height, otherX, otherY, otherWidth, otherHeight) then
			hor = horizontalCollide(objName, objData, obj2Name, obj2Data) 
		elseif aabb(x, verY, width, height, otherX, otherY, otherWidth, otherHeight) then
			ver = verticalCollide(objName, objData, obj2Name, obj2Data)
		end
	else
		checkPassive(objData, objName, obj2Data, obj2Name, dt)
	end

	return hor, ver
end

function checkrectangle(x, y, width, height, check, callback, allow)
	local ret = {}
	local checkObjects = check or {}
	local exclude
	
	if type(check) == "table" and check[1] == "exclude" then
		checkObjects = "all"
		exclude = check[2]
	end

	local obj = false
	for i, v in pairs(cache) do
		for j = 1, #check do
			if v[1] == check[j] then
				obj = v[2]
			end
		end
	end

	if obj then
		if aabb(x, y, width, height, obj.x, obj.y, obj.width, obj.height) then
			table.insert(ret, obj)
		end
	end

	return ret
end

function horizontalCollide(objName, objData, obj2Name, obj2Data)
	if objData.speed.x > 0 then
		if objData.rightCollide then --first object collision
			if objData:rightCollide(obj2Name, obj2Data) ~= false then
				if objData.speed.x > 0 then
					objData.speed.x = 0
				end
				objData.x = obj2Data.x - objData.width
				return true
			end
		else 
			if objData.speed.x > 0 then
				objData.speed.x = 0
			end
			objData.x = obj2Data.x - objData.width
			return true
		end	

		if obj2Data.leftCollide then --opposing object collides
			if obj2Data:leftCollide(objName, objData) ~= false then
				if obj2Data.speed.x < 0 then
					obj2Data.speed.x = 0
				end
			end
		else
			if obj2Data.speed.x < 0 then
				obj2Data.speed.x = 0
			end
		end
	else
		if objData.leftCollide then
			if objData:leftCollide(obj2Name, obj2Data) ~= false then
				if objData.speed.x < 0 then
					objData.speed.x = 0
				end
				objData.x = obj2Data.x + obj2Data.width
				return true
			end
		else 
			if objData.speed.x < 0 then
				objData.speed.x = 0
			end
			objData.x = obj2Data.x + obj2Data.width
			return true
		end

		if obj2Data.rightCollide then
			--Item 2 collides..
			if obj2Data:rightCollide(objName, objData) ~= false then
				if obj2Data.speed.x > 0 then
					obj2Data.speed.x = 0
				end
			end
		else
			if obj2Data.speed.x > 0 then
				obj2Data.speed.x = 0
			end
		end
	end

	return false
end

function verticalCollide(objName, objData, obj2Name, obj2Data)
	if objData.speed.y > 0 then
		if objData.downCollide then --first object collision
			if objData:downCollide(obj2Name, obj2Data) ~= false then
				if objData.speed.y > 0 then
					objData.speed.y = 0
				end
				objData.y = obj2Data.y - objData.height
				return true
			end
		else
			if objData.speed.y > 0 then
				objData.speed.y = 0
			end
			objData.y = obj2Data.y - objData.height
			return true
		end	

		if obj2Data.upCollide then --opposing object collides
			--Item 2 collides..
			if obj2Data:upCollide(objName, objData) ~= false then
				if obj2Data.speed.y < 0 then
					obj2Data.speed.y = 0
				end
			end
		else
			if obj2Data.speed.y < 0 then
				obj2Data.speed.y = 0
			end
		end
	else
		if objData.upCollide then
			if objData:upCollide(obj2Name, obj2Data) ~= false then
				if objData.speed.y < 0 then
					objData.speed.y = 0
				end
				objData.y = obj2Data.y + obj2Data.height
				return true
			end
		else 
			if objData.speed.y < 0 then
				objData.speed.y = 0
			end
			objData.y = obj2Data.y + obj2Data.height
			return true
		end

		if obj2Data.downCollide then
			--Item 2 collides..
			if obj2Data:downCollide(objName, objData) ~= false then
				if obj2Data.speed.y > 0 then
					obj2Data.speed.y = 0
				end
			end
		else
			if obj2Data.speed.y > 0 then
				obj2Data.speed.y = 0
			end
		end
	end

	return false
end

function aabb(x, y, width, height, otherX, otherY, otherWidth, otherHeight)
	return x + width > otherX and x < otherX + otherWidth and y + height > otherY and y < otherY + otherHeight
end