--[[
	Turtle's Physics Library
	All code is mine.
	(c) 2015 Tiny Turtle Industries
	(Obviously same licensing as the game)
	v1.2
--]]

local floor = math.floor
local dist = util.dist
local abs = math.abs

--[[
1. Tile
2. Player
3. Barrier
4. Phoenix/Door? Wat
5. Crate
6. AI
7. Health
--]]

function physicsupdate(dt)
	for cameraIndex, cameraValue in ipairs(cameraObjects) do
		local objName, objData, objIndex = cameraValue[1], cameraValue[2], cameraValue[3]
		
		if objData.active and not objData.static then
			local hor, ver = false, false

			objData.speedy = math.min(objData.speedy + objData.gravity * dt, 15 * 60) --add gravity to objects

			--VS THINGS NOT TILES
			if objData.mask and not objData.passive then
				for cameraOtherIndex, cameraOtherValue in ipairs(cameraObjects) do
					local checkCategory, versusCategory = cameraValue[2].category, cameraOtherValue[2].category

					if objData ~= cameraOtherValue[2] and objData.mask[versusCategory] then
						local obj2Name, obj2Data = cameraOtherValue[1], cameraOtherValue[2]
						hor, ver = checkCollision(objData, objName, obj2Data, obj2Name, dt)
					end
				end
			end

			if hor == false then
				objData.x = objData.x + objData.speedx * dt
			end

			if ver == false then
				objData.y = objData.y + objData.speedy * dt
			end
		end

		if objData.remove then
			table.remove(objects[objName], objIndex)
		end

		if objData.update then
			objData:update(dt)
		end
	end
end

function checkPassive(objData, objName, obj2Data, obj2Name, dt)
	if aabb(objData.x + objData.speedx * dt, objData.y + objData.speedy * dt, objData.width, objData.height, obj2Data.x, obj2Data.y, obj2Data.width, obj2Data.height) then
		if objData.passiveCollide then
			objData:passiveCollide(obj2Name, obj2Data)
		end
	end
end

function checkCollision(objData, objName, obj2Data, obj2Name, dt)
	local hor, ver = false, false

	--local time = love.timer.getTime()

	local horX, y = objData.x + objData.speedx * dt, objData.y
	local x, verY = objData.x, objData.y + objData.speedy * dt
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

	--print(string.format("Calculation {" .. objName .. " vs " .. obj2Name .. "} done in: %.3f ms.", (love.timer.getTime() - time) * 1000))

	return hor, ver
end

function checkCamera(x, y, width, height)
	local ret = {}

	for i, v in pairs(objects) do
		for j, w in ipairs(v) do
			if aabb(x, y, width, height, w.x, w.y, w.width, w.height) then
				table.insert(ret, {i, w, j})
			end
		end
	end

	return ret
end

function checkrectangle(x, y, width, height, check, callback, allow)
	local ret = {}
	local checkObjects = "list"
	local exclude
	
	if type(check) == "table" and check[1] == "exclude" then
		checkObjects = "all"
		exclude = check[2]
	end

	for i, t in pairs(objects) do
		local hasObject = false
		if check and checkObjects ~= "all" then
			for j = 1, #check do
				if i == check[j] then --matching numerical indecies
					hasObject = true
				end
			end
		end

		if checkObjects == "all" or hasObject then
			for j, v in ipairs(t) do
				if allow or checkObjects ~= "all" then
					local skip = false
					if exclude then
						if v.x == exclude.x and v.y == exclude.y then
							skip = true
						end
					end

					if not skip then
						if v.active then
							if aabb(x, y, width, height, v.x, v.y, v.width, v.height) then
								table.insert(ret, {j, v})
							end
						end
					end
				end
			end
		end
	end

	return ret
end

function horizontalCollide(objName, objData, obj2Name, obj2Data)
	if objData.speedx > 0 then
		if objData.rightCollide then --first object collision
			if objData:rightCollide(obj2Name, obj2Data) ~= false then
				if objData.speedx > 0 then
					objData.speedx = 0
				end
				objData.x = obj2Data.x - objData.width
				return true
			end
		else 
			if objData.speedx > 0 then
				objData.speedx = 0
			end
			objData.x = obj2Data.x - objData.width
			return true
		end	

		if obj2Data.leftCollide then --opposing object collides
			if obj2Data:leftCollide(objName, objData) ~= false then
				if obj2Data.speedx < 0 then
					obj2Data.speedx = 0
				end
			end
		else
			if obj2Data.speedx < 0 then
				obj2Data.speedx = 0
			end
		end
	else
		if objData.leftCollide then
			if objData:leftCollide(obj2Name, obj2Data) ~= false then
				if objData.speedx < 0 then
					objData.speedx = 0
				end
				objData.x = obj2Data.x + obj2Data.width
				return true
			end
		else 
			if objData.speedx < 0 then
				objData.speedx = 0
			end
			objData.x = obj2Data.x + obj2Data.width
			return true
		end

		if obj2Data.rightCollide then
			--Item 2 collides..
			if obj2Data:rightCollide(objName, objData) ~= false then
				if obj2Data.speedx > 0 then
					obj2Data.speedx = 0
				end
			end
		else
			if obj2Data.speedx > 0 then
				obj2Data.speedx = 0
			end
		end
	end

	return false
end

function verticalCollide(objName, objData, obj2Name, obj2Data)
	if objData.speedy > 0 then
		if objData.downCollide then --first object collision
			if objData:downCollide(obj2Name, obj2Data) ~= false then
				if objData.speedy > 0 then
					objData.speedy = 0
				end
				objData.y = obj2Data.y - objData.height
				return true
			end
		else
			if objData.speedy > 0 then
				objData.speedy = 0
			end
			objData.y = obj2Data.y - objData.height
			return true
		end	

		if obj2Data.upCollide then --opposing object collides
			--Item 2 collides..
			if obj2Data:upCollide(objName, objData) ~= false then
				if obj2Data.speedy < 0 then
					obj2Data.speedy = 0
				end
			end
		else
			if obj2Data.speedy < 0 then
				obj2Data.speedy = 0
			end
		end
	else
		if objData.upCollide then
			if objData:upCollide(obj2Name, obj2Data) ~= false then
				if objData.speedy < 0 then
					objData.speedy = 0
				end
				objData.y = obj2Data.y + obj2Data.height
				return true
			end
		else 
			if objData.speedy < 0 then
				objData.speedy = 0
			end
			objData.y = obj2Data.y + obj2Data.height
			return true
		end

		if obj2Data.downCollide then
			--Item 2 collides..
			if obj2Data:downCollide(objName, objData) ~= false then
				if obj2Data.speedy > 0 then
					obj2Data.speedy = 0
				end
			end
		else
			if obj2Data.speedy > 0 then
				obj2Data.speedy = 0
			end
		end
	end

	return false
end

function aabb(v1x, v1y, v1width, v1height, v2x, v2y, v2width, v2height)
	return v1x + v1width > v2x and v1x < v2x + v2width and v1y + v1height > v2y and v1y < v2y + v2height
end