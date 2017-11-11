function testInit()
	cameraObjects = {}
	objects = {}
	dialogs = {}
	smokes = {}

	love.graphics.setBackgroundColor(backgroundColors.midnight)

	tiled:setMap("test")

	objects["tile"] = tiled:getTiles()
	objects["player"] = {turtle:new(200, 200)}
	objects["health"] = {}
	objects["coin"] = {}
	prefabs = {}

	touchLocation = {0, 0}

	currentItem = 1
	spawnables =
	{
		"player",
		"hermit",
		"spider",
		"bat",
		"health",
		"coin",
		"lantern",
		"container"
	}

	gameHUD = hud:new()
	gameHUD:adjust()

	debugData = 
	{
		["Region"] = love.system.getRegion(),
		["Model"] = love.system.getModel(),
		["Object"] = "",
		["Spawn Location"] = ""
	}

	debugGUI =
	{
		gui:new("list", 0, 0, 64, 14, "Spawn Object:", spawnables)
	}

	quitTimer = 0

	table.insert(objects["coin"], coin:new(128, 16, 1))
	table.insert(objects["coin"], coin:new(164, 16, 5))
	table.insert(objects["coin"], coin:new(200, 16, 10))
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

	for j, w in ipairs(prefabs) do
		for s = 1, #w do
			w[s]:update(dt)
		end

		if w.update then
			w:update(dt)
		end

		if w.remove then
			table.remove(prefabs, j)
		end
	end

	physicsupdate(dt)

	gameHUD:update(dt)

	if love.keyboard.isDown("x") then
		quitTimer = quitTimer + dt
		if quitTimer > 1 then
			util.changeState("title")
		end
	else
		quitTimer = 0
	end
end

function testDraw()
	love.graphics.setScreen('top')

	tiled:renderBackground()

	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.setFont(gameFont)
	love.graphics.print("TEST MODE", (400 - gameFont:getWidth("TEST MODE")) / 2, 0)
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

	for i, v in ipairs(prefabs) do
		for j, w in ipairs(v) do
			if w.draw then
				w:draw()
			end
		end

		if v.draw then
			v:draw()
		end
	end

	love.graphics.setColor(255, 0, 0, 164)
	love.graphics.rectangle("fill", math.floor(touchLocation[1] / 16) * 16, math.floor(touchLocation[2] / 16) * 16, 16, 16)

	love.graphics.setColor(255, 255, 255, 255)

	gameHUD:draw()
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.setScreen('bottom')

	for k, v in ipairs(debugGUI) do
		v:draw()
	end

	if love.mouse.isDown(1) then
		local y = love.mouse.getY()
		if _EMULATEHOMEBREW then
			y = y - 240
		end
		touchLocation = {util.clamp(util.round((love.mouse.getX() - 40) / 320, 2) * 400, 0, 384), util.clamp(y, 0, 240)}
	end
end

function testKeyPressed(key)
	for k, v in ipairs(debugGUI) do
		v:keypressed(key)
	end

	if key == "select" then
		local spawn = debugGUI[1]:getValue()

		if not objects[spawn] then
			objects[spawn] = {}
		end

		local x, y = math.floor(touchLocation[1] / 16) * 16, math.floor(touchLocation[2] / 16) * 16

		if spawn == "lantern" then
			table.insert(objects["tile"], tile:new(x, y, 16, 16, {breakable = true, passive = true, id = 305}))
			return
		elseif spawn == "player" then
			if not objects["player"][1]:isDead() then
				objects["player"][1].x, objects["player"][1].y = touchLocation[1], touchLocation[2]
			else
				objects["player"] = {turtle:new(200, 200)}
			end
		else
			table.insert(objects[spawn], _G[spawn]:new(x, y))
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