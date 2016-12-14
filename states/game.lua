function gameInit(map)
    gameFade = 1
    fadeValue = 1
    otherFade = 1
    gameFadeOut = false

	eventSystem = eventsystem:new()

	dialogs = {}

	gameHUD = hud:new()
	pause = pausemenu:new()

	paused = false

	shakeValue = 0

	gameCreateTables()

	if map then
		tiled:setMap(map)
	end
	
	if cutscenes[currentScript] then
		eventSystem:decrypt(cutscenes[currentScript][1])
	end

	cameraObjects = {}
end

function gameCreateTables()
	scrollValues =
    {
        ["top"] = {0, 0},
        ["bottom"] = {0, 0}
    }

	--[[

		OBJECTS LIST

		1: TILES
		2: objects["player"][1]
		3: DOOR
		4: BARRIER

	--]]

    objects = {}
    objects["tile"] = tiled:getTiles()
    objects["player"] = {turtle:new(SPAWN_X, SPAWN_Y)}
	
	objects["barrier"] =
	{
		barrier:new(0, 0, 1, 240),
		barrier:new(400, 0, 1, 240)
	}
	
	objects["phoenix"] = {}
	
	prefabs = tiled:getObjects({"bed", "clock", "door"})

	
end

function gameUpdate(dt)
	if paused then
		return
	end

	cameraObjects = checkCamera(getScrollValue(), 0, 432, 248)
	
	if shakeValue > 0 then
		shakeValue = shakeValue - dt / 0.3
	end

    if gameFadeOut then
		if gameFade < 1 then
			gameFade = math.min(gameFade + fadeValue * dt, 1)
		else
			if fadeValue ~= 1 then
				fadeValue = 1
			end

			if gameFade == 1 and deathRestart then
				gameLoadMap(currentLevel, true)
			end
		end
	else
		if gameFade > 0 then
			gameFade = math.max(gameFade - fadeValue * dt, 0)
		else
			if fadeValue ~= 1 then
				fadeValue = 1
			end
		end
	end

    physicsupdate(dt)

	eventSystem:update(dt)

	for i = 1, #prefabs do
		for j = 1, #prefabs[i] do
			prefabs[i][j]:update(dt)
		end
	end

    for k, v in ipairs(clouds) do
		v:update(dt)
	end

	for k, v in ipairs(dialogs) do
		v:update(dt)

		if v.remove then
			table.remove(dialogs, k)
		end
	end
end

function gameDraw()
    love.graphics.setScreen("top")

	love.graphics.setColor(255, 255, 255)

	love.graphics.push()

	if shakeValue > 0 then
		love.graphics.translate(math.floor( (math.random() * 2 - 1) * shakeValue ), math.floor( (math.random() * 2 - 1)  * shakeValue))
	end

	for k, v in ipairs(stars) do
	    love.graphics.rectangle("fill", v[1], v[2], 1, 1)
	end

	tiled:renderBackground()

	for i = 1, #prefabs do
		for j = 1, #prefabs[i] do
			prefabs[i][j]:draw()
		end
	end
	
    for i, v in ipairs(cameraObjects) do
		if v[2].draw then
			v[2]:draw()
		end
	end

	for k, v in ipairs(clouds) do
		if tiled:getMapName() == "home" then
			v:draw()
		end
	end

	love.graphics.pop()

	for k, v in pairs(dialogs) do
		v:draw()
	end

	gameHUD:draw()

	love.graphics.setColor(0, 0, 0, 255 * gameFade)
	love.graphics.rectangle("fill", 0, 0, util.getWidth(), util.getHeight())

	love.graphics.setScreen("bottom")
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill", 0, 0, util.getWidth(), util.getHeight())

	love.graphics.setColor(255, 255, 255)

	if paused then
		pause:draw()
	end
end

function gameKeyPressed(key)
	if key == "x" or key == "start" then
		paused = not paused
	end

	if paused then
		pause:keypressed(key)
		return
	end

	if objects["player"][1].frozen then
		return
	end

    if key == "right" then
        objects["player"][1]:moveRight(true)
    elseif key == "left" then
        objects["player"][1]:moveLeft(true)
    elseif key == "a" then
		objects["player"][1]:jump()
	elseif key == "up" then
		objects["player"][1]:use(true)
	end
end

function gameKeyReleased(key)
    if key == "right" then
        objects["player"][1]:moveRight(false)
    elseif key == "left" then
        objects["player"][1]:moveLeft(false)
    elseif key == "a" then
		objects["player"][1]:stopJump()
	elseif key == "up" then
		objects["player"][1]:use(false)
	end
end

function gameMousePressed(x, y)

end

function gameNewDialog(text)
	table.insert(dialogs, dialog:new(text))
end

function getScrollValue()
    return math.floor(scrollValues[objects["player"][1].screen][1])
end