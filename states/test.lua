function testInit()
	cameraObjects = {}
	objects = {}
	dialogs = {}
	smokes = {}

	tiled:setMap("test")

	objects["tile"] = tiled:getTiles()
	objects["player"] = {turtle:new(SPAWN_X, SPAWN_Y)}
	objects["health"] = {}

	touchLocation = {0, 0}

	currentItem = 1
	spawnables =
	{
		"player",
		"hermit",
		"spider",
		"bat",
		"health"
	}

	gameHUD = hud:new()

	debugData = 
	{
		["Region"] = love.system.getRegion(),
		["Model"] = love.system.getModel(),
		["Object"] = "",
		["Spawn Location"] = ""
	}

	love.graphics.setLineWidth(1)
end

function testUpdate(dt)
	cameraObjects = checkCamera(0, 0, 432, 248)

	for i, v in ipairs(smokes) do
		if v.remove then
			table.remove(smokes, i)
		end
		v:update(dt)
	end

	for k, v in ipairs(dialogs) do
		v:update(dt)

		if v.remove then
			table.remove(dialogs, k)
		end
	end

	physicsupdate(dt)

	gameHUD:update(dt)
end

function testDraw()
	love.graphics.setScreen('top')

	tiled:renderBackground()

	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.setFont(smallFont)
	love.graphics.print("TEST MODE", (400 - smallFont:getWidth("TEST MODE")) / 2, 0)
	love.graphics.line(8, 8, 154, 8)
	love.graphics.line(248, 8, 392, 8)
	
	for i, v in ipairs(cameraObjects) do
		if v[2].draw then
			v[2]:draw()
		end
	end

	for i, v in ipairs(smokes) do
		v:draw()
	end

	for k, v in pairs(dialogs) do
		v:draw()
	end

	love.graphics.setColor(255, 0, 0, 164)
	love.graphics.rectangle("fill", math.floor(touchLocation[1] / 16) * 16, math.floor(touchLocation[2] / 16) * 16, 16, 16)

	love.graphics.setColor(255, 255, 255, 255)

	gameHUD:draw()

	love.graphics.setScreen('bottom')

	debugData["Object"] = spawnables[currentItem]
	debugData["Spawn Location"] = table.concat(touchLocation, ",")

	local j = 1
	for i, v in pairs(debugData) do
		love.graphics.print(i .. ": " .. v, 0, 0 + (j - 1) * 11)
		j = j + 1
	end
	love.graphics.print("Press 'Select' to spawn", 0, 44)
	love.graphics.print("Press 'Start' to clear", 0, 55)

	if love.mouse.isDown(1) then
		local y = love.mouse.getY()
		if _EMULATEHOMEBREW then
			y = y - 240
		end
		touchLocation = {util.clamp(util.round((love.mouse.getX() - 40) / 320, 2) * 400, 0, 384), util.clamp(y, 0, 240)}
	end
end

function testKeyPressed(key)
	if key == "rbutton" then
		currentItem = math.min(currentItem + 1, #spawnables)
	elseif key == "lbutton" then
		currentItem = math.max(currentItem - 1, 1)
	end

	if key == "select" then
		if _G[spawnables[currentItem]] then
			if not objects[spawnables[currentItem]] then
				objects[spawnables[currentItem]] = {}
			end

			local x, y = math.floor(touchLocation[1] / 16) * 16, math.floor(touchLocation[2] / 16) * 16
			table.insert(objects[spawnables[currentItem]], _G[spawnables[currentItem]]:new(x, y))
		else
			if spawnables[currentItem] == "player" then
				objects["player"][1].x, objects["player"][1].y = touchLocation[1], touchLocation[2]
			end
		end
	elseif key == "start" then
		for k, v in pairs(objects) do
			for j, w in ipairs(v) do
				if k ~= "tile" and k ~= "player" then
					table.remove(objects[k], j)
				end
			end
		end
	end

	if (not objects["player"][1].render or objects["player"][1].frozen or objects["player"][1].dead) then
		if not objects["player"][1].render then
			if key == "up" then
				objects["player"][1]:use(true)
				return
			end
		end 
		return
	end

	if key == controls["right"] then
		objects["player"][1]:moveRight(true)
	elseif key == controls["left"] then
		objects["player"][1]:moveLeft(true)
	elseif key == controls["jump"] then
		objects["player"][1]:jump()
	elseif key == controls["up"] then
		objects["player"][1]:use(true)
	elseif key == controls["down"] then
		objects["player"][1]:duck(true)
	elseif key == controls["punch"] then
		objects["player"][1]:punch(true)
	end
end

function testKeyReleased(key)
	if key == controls["right"] then
		objects["player"][1]:moveRight(false)
	elseif key == controls["left"] then
		objects["player"][1]:moveLeft(false)
	elseif key == controls["jump"] then
		objects["player"][1]:stopJump()
	elseif key == controls["down"] then
		objects["player"][1]:duck(false)
	elseif key == controls["up"] then
		objects["player"][1]:use(false)
	elseif key == controls["punch"] then
		objects["player"][1]:punch(false)
	end
end