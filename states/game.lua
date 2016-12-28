function gameInit(map)
	if titleSong then
		titleSong:stop()
		titleSong = nil

		collectgarbage()
		collectgarbage()
	end

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
	
	if map then
		tiled:setMap(map)
	end
	
	love.graphics.setBackgroundColor(backgroundColors.sky)
	
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
	
    objects["tile"] = tiled:getTiles()

	if not objects["player"] then
		objects["player"] = {}
    	objects["player"] = {turtle:new(SPAWN_X, SPAWN_Y)}
	else
		objects["player"][1].x, objects["player"][1].y = SPAWN_X, SPAWN_Y
	end

	objects["barrier"] = {}
	
	if not tiled:getNextMap("left") then
		objects["barrier"][1] = barrier:new(0, 0, 1, 240)
	end

	if not tiled:getNextMap("right") then
		objects["barrier"][2] = barrier:new(400, 0, 1, 240)
	end

	objects["phoenix"] = {}
	objects["hermit"] = tiled:getObjects("hermit")

	hitNumbers = {}

	prefabs = tiled:getObjects({"bed", "clock", "door", "palm", "trigger", "water"})
end

function gameUpdate(dt)
	if paused then
		return
	end

	cameraObjects = checkCamera(getScrollValue(), 0, 432, 248)

	saveManager:tick(dt)

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

	for j, w in ipairs(prefabs) do
		for s = 1, #w do
			w[s]:update(dt)
		end
	end

	for i, v in ipairs(hitNumbers) do
		v:update(dt)

		if v.remove then
			table.remove(hitNumbers, i)
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

	love.graphics.setDepth(ENTITY_DEPTH)

	tiled:renderBackground()

	for i = 1, #prefabs do
		for j = 1, #prefabs[i] do
			if prefabs[i][j].draw then
				prefabs[i][j]:draw()
			end
		end
	end

	for i, v in ipairs(hitNumbers) do
		v:draw()
	end

	for k, v in ipairs(clouds) do
		if tiled:getMapName() == "home" then
			v:draw()
		end
	end

    for i, v in ipairs(cameraObjects) do
		if v[2].draw then
			v[2]:draw()
		end
	end

	love.graphics.setDepth(NORMAL_DEPTH)

	love.graphics.pop()

	love.graphics.setDepth(INTERFACE_DEPTH)

	for k, v in pairs(dialogs) do
		v:draw()
	end

	gameHUD:draw()

	if paused then
		pause:draw()
	end

	love.graphics.setDepth(NORMAL_DEPTH)

	love.graphics.setColor(0, 0, 0, 255 * gameFade)
	love.graphics.rectangle("fill", 0, 0, util.getWidth(), util.getHeight())

	love.graphics.setScreen("bottom")
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill", 0, 0, util.getWidth(), util.getHeight())

	love.graphics.setColor(255, 255, 255)
end

function gameKeyPressed(key)
	if key == "start" then
		paused = not paused
	end

	if paused then
		pause:keypressed(key)
		return
	end

	if (not objects["player"][1].render or objects["player"][1].frozen) and not objects["player"][1].invincible then
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
	elseif key == controls["punch"] then
		objects["player"][1]:punch()
	end
end

function gameKeyReleased(key)
	if key == controls["right"] then
        objects["player"][1]:moveRight(false)
    elseif key == controls["left"] then
        objects["player"][1]:moveLeft(false)
    elseif key == controls["jump"] then
		objects["player"][1]:stopJump()
	elseif key == controls["up"] then
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