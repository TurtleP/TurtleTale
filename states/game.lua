function gameInit(map)
	if titleSong then
		titleSong:stop()
		titleSong = nil

		collectgarbage()
		collectgarbage()
	end

	gameOver = false

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
	
	clouds = {}
	for x = 1, 8 do
		clouds[x] = cloud:new(math.random(love.graphics.getWidth()), math.random(love.graphics.getHeight() * 0.05, love.graphics.getHeight() * 0.4), math.random(30, 35))
	end

	if map then
		tiled:setMap(map)
		gameCreateTables()
	end
	
	love.graphics.setBackgroundColor(backgroundColors.sky)
	
	if cutscenes[currentScript] then
		eventSystem:decrypt(cutscenes[currentScript][1])
	end

	mapScroll = 0
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

		if objects["player"][1].dead then
			objects["player"] = {turtle:new(SPAWN_X, SPAWN_Y)}
		end
	end

	objects["barrier"] = {}
	
	if not tiled:getNextMap("left") then
		table.insert(objects["barrier"], barrier:new(0, 0, 1, 240))
	end

	if not tiled:getNextMap("right") then
		table.insert(objects["barrier"], barrier:new(tiled:getWidth("top") * 16, 0, 1, 240))
	end

	objects["phoenix"] = {}
	objects["hermit"] = tiled:getObjects("hermit")

	hitNumbers = {}

	prefabs = tiled:getObjects({"bed", "clock", "door", "palm", "trigger", "water"})
end

function cameraScroll()
    local MAP_WIDTH = tiled:getWidth("top")
    local self = objects["player"][1]

    if tiled:getWidth("top") > 25 then
		if mapScroll >= 0 and mapScroll + love.graphics.getWidth() <= MAP_WIDTH * 16 then
			if self.x > mapScroll + love.graphics.getWidth() * 1 / 2 then
				mapScroll = self.x - love.graphics.getWidth() * 1 / 2
			elseif self.x < mapScroll + love.graphics.getWidth() * 1 / 2 then
				mapScroll = self.x - love.graphics.getWidth() * 1 / 2
			end
		end

		if mapScroll < 0 then
			mapScroll = 0
		elseif mapScroll + 400 >= MAP_WIDTH * 16 then
			mapScroll = MAP_WIDTH * 16 - 400
		end
	end
end

function gameUpdate(dt)
	if paused and not gameOver then
		return
	end

	if not eventSystem:isRunning() then
		tiled:playCurrentSong()
	end

	if gameOver then
		if not pitDeathSound:isPlaying() then
			if not gameFadeOut then
				gameFadeOut = true
			end
		end
	end

	--[[
	local state, percent = love.system.getPowerInfo()

	if percent then
		if not chargeEasterEgg and state ~= "charging" then
			if percent < 20 then
				gameNewDialog("turtle", "Oh darn, I think the system is running low on COFFEI! Please plug it in so it does not shut down.")
				chargeEasterEgg = true
			end
		else
			if percent > 20 and state == "charging" then
				chargeEasterEgg = false
			end
		end
	end
	]]--

	cameraScroll()
	cameraObjects = checkCamera(mapScroll, 0, 432, 248)

	saveManager:tick(dt)

	if shakeValue > 0 then
		shakeValue = math.max(shakeValue - dt / 0.3, 0)
	end

    if gameFadeOut then
		if gameFade < 1 then
			gameFade = math.min(gameFade + fadeValue * dt, 1)
		else
			if fadeValue ~= 1 then
				fadeValue = 1
			end

			if gameOver then
				util.changeState("gameOver")
			end

			if skipScene then
				gameInit(tiled:getMapName())
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

	gameHUD:update(dt)
end

function gameDraw()
    love.graphics.setScreen("top")

	love.graphics.setColor(255, 255, 255)

	love.graphics.push()

	if shakeValue > 0 then
		love.graphics.translate((math.random() * 2 - 1) * shakeValue, 0)
	end

	love.graphics.draw(backgroundImages["sky"])

	love.graphics.translate(-math.floor(mapScroll), 0)

	love.graphics.setDepth(ENTITY_DEPTH)

	for k, v in ipairs(clouds) do
		if tiled:getMapName() ~= "indoors" then
			v:draw()
		end
	end

	tiled:renderBackground()

	for i, v in ipairs(prefabs) do
		for j, w in ipairs(v) do
			if w.draw then
				w:draw()
			end
		end
	end

	for i, v in ipairs(hitNumbers) do
		v:draw()
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

	if eventSystem:isRunning() then
		if key == "a" then
			skipScene = true
			gameFadeOut = true
			return
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

function gameKeyReleased(key)
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

function gameMousePressed(x, y)

end

function gameNewDialog(speaker, text)
	table.insert(dialogs, dialog:new(speaker, text))
end

function getScrollValue()
    return math.floor(scrollValues[objects["player"][1].screen][1])
end