function gameInit(map)
	if titleSong then
		titleSong:stop()
		titleSong = nil

		collectgarbage()
		collectgarbage()
	end

	gameFade = 1
	fadeValue = 1
	gameFadeOut = false
	shakeValue = 0

	dialogs = {}
	paused = false

	mapScroll = 0
	cameraObjects = {}

	bottomScreenFade = 1
	local color = backgroundColors.sky
	if map == "indoors" then
		color = backgroundColors.indoors
	end
	love.graphics.setBackgroundColor(color)

	if not objects["player"] then
		objects["player"] = {turtle:new(SPAWN_X, SPAWN_Y)}
	else
		objects["player"][1]:reset(SPAWN_X, SPAWN_Y)

		if objects["player"][1].dead then
			objects["player"] = {turtle:new(SPAWN_X, SPAWN_Y)}
		end
	end

	if map then
		tiled:setMap(map)
		gameCreateTables()
	end

	eventSystem = eventsystem:new()
	for i, v in pairs(cutscenes) do
		if not v[1].manual and not v[2] then
			eventSystem:decrypt(i, cutscenes[i][1]) --load each or something
		end
	end

	if not gameHUD then
		gameHUD = hud:new()
	end
	gameHUD:adjust()
	
	if HIDDEN_ITEMS[tiled:getMapName()] then
		local data = HIDDEN_ITEMS[tiled:getMapName()]

		for i = 1, #data do
			if not data[i].used then
				table.insert(prefabs, userectangle:new(data[i].x, data[i].y, 16, 16, data[i].func, true, true, data[i]))
			end
		end
	end

	if not MAP_DATA[tiled:getMapName()]  then
		MAP_DATA[tiled:getMapName()] = {}
	else
		for k, v in pairs(objects) do
			for j, w in pairs(v) do
				gameCheckTable(w)
			end
		end

		for k, v in ipairs(prefabs) do
			for j, w in ipairs(v) do
				gameCheckTable(w)
			end
		end
	end

	currentScissor = {tiled:getOffset(), 0, tiled:getWidth("top") * 16, 240}
end

function gameCheckTable(object)
	for obj, data in pairs(MAP_DATA[tiled:getMapName()]) do
		if object.x == data[1] and object.y == data[2] then
			print(object)
			if object.fix then
				print(object)
				object:fix()
			else
				if object:isInstanceOf(turtle) then
					return
				end
				object.remove = true
			end
		end
	end
end

function gameCreateTables()
	scrollValues =
	{
		["top"] = {0, 0},
		["bottom"] = {0, 0}
	}
	
	objects["tile"] = tiled:getObjects("tile")

	objects["barrier"] = {}
	
	if not tiled:getNextMap("left") then
		table.insert(objects["barrier"], barrier:new(0, 0, 1, 240))
	end

	if not tiled:getNextMap("right") then
		table.insert(objects["barrier"], barrier:new(tiled:getWidth("top") * 16, 0, 1, 240))
	end

	objects["phoenix"] = {}
	objects["hermit"] = tiled:getObjects("hermit")
	objects["chest"] = tiled:getObjects("chest")
	objects["crate"] = tiled:getObjects("crate")
	objects["container"] = {}
	objects["fish"] = {}
	objects["health"] = {}
	objects["coin"] = {}
	objects["spider"] = tiled:getObjects("spider")
	objects["bat"] = tiled:getObjects("bat")
	objects["fireball"] = {}
	objects["shopkeeper"] = tiled:getObjects("shopkeeper")
	objects["block"] = tiled:getObjects("block")
	objects["boss"] = tiled:getObjects("hermitboss")

	smokes = {}

	prefabs = tiled:getObjects({"bed", "clock", "door", "palm", "trigger", "water", "sign", "house", "bossdoor"})
end

function cameraScroll()
	local MAP_WIDTH = tiled:getWidth("top")
	local self = objects["player"][1]

	if tiled:getWidth("top") > 25 then
		if mapScroll >= 0 and mapScroll + util.getWidth() <= MAP_WIDTH * 16 then
			if self.x > mapScroll + util.getWidth() * 1 / 2 then
				mapScroll = self.x - util.getWidth() * 1 / 2
			elseif self.x < mapScroll + util.getWidth() * 1 / 2 then
				mapScroll = self.x - util.getWidth() * 1 / 2
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
	if paused then
		return
	end

	if not eventSystem:isRunning() then
		tiled:playCurrentSong()
	end

	cameraScroll()
	cameraObjects = checkCamera(mapScroll, -32, 432, 280)

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

	for i, v in ipairs(smokes) do
		if v.remove then
			table.remove(smokes, i)
		end
		v:update(dt)
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

	for k, v in ipairs(clouds) do
		v:update(dt)
	end

	for k, v in ipairs(dialogs) do
		v:update(dt)

		if v.remove then
			table.remove(dialogs, k)
		end
	end
	objects["player"][1].inventory:update(dt)

	gameHUD:update(dt)
end

function gameDraw()
	love.graphics.setScreen("top")

	love.graphics.setColor(255, 255, 255)

	love.graphics.push()

	if not paused then
		if shakeValue > 0 then
			love.graphics.translate(util.round((math.random() * 2 - 1) * shakeValue, 2), 0)
		end
	end

	love.graphics.translate(-math.floor(mapScroll), 0)

	love.graphics.setDepth(ENTITY_DEPTH)

	love.graphics.setScissor(unpack(currentScissor))

	for k, v in ipairs(clouds) do
		if gameClouds[tiled:getMapName()] then
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

		if v.draw then
			v:draw()
		end
	end

	for i, v in ipairs(smokes) do
		v:draw()
	end

	for i, v in ipairs(cameraObjects) do
		
		if v[2].customScissor then
			local scissor = v[2].customScissor

			local off = tiled:getOffset()
			if off == -mapScroll then
				off = 0
			end
			love.graphics.setScissor(off + scissor[1] - mapScroll, scissor[2], scissor[3], scissor[4])
		else
			love.graphics.setScissor(unpack(currentScissor))
		end

		if v[1] ~= "player" and v[1] ~= "chest" then
			if v[2].draw then
				v[2]:draw()
			end
		end

		if v[1] == "chest" then
			v[2]:draw()
		end

		love.graphics.setScissor()
	end

	love.graphics.setColor(255, 255, 255, 255)

	objects["player"][1]:draw()

	love.graphics.setDepth(NORMAL_DEPTH)

	love.graphics.pop()

	love.graphics.setDepth(INTERFACE_DEPTH)

	gameHUD:draw()

	if paused then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.print("PAUSED", love.graphics.getWidth() / 2 - gameFont:getWidth("PAUSED") / 2, love.graphics.getHeight() / 2 - gameFont:getHeight() / 2)
	end

	love.graphics.setDepth(NORMAL_DEPTH)

	love.graphics.setColor(0, 0, 0, 255 * gameFade)
	love.graphics.rectangle("fill", 0, 0, util.getWidth(), util.getHeight())

	for k, v in pairs(dialogs) do
		v:draw()
	end

	love.graphics.setScissor()

	love.graphics.setScreen("bottom")

	objects["player"][1].inventory:draw()
end

function gameKeyPressed(key)
	if key == "start" then
		paused = not paused
	end

	if paused then
		return
	end

	if #dialogs > 0 then
		if dialogs[1].prompt then
			dialogs[1].prompt:keypressed(key)
			return
		end
	end

	if SHOP_OPEN then
		objects["shopkeeper"][1]:keypressed(key)
	end

	objects["player"][1].inventory:keypressed(key)

	if objects["player"][1].frozen or objects["player"][1].dead then
		return
	end

	if not objects["player"][1]:isDucking() then
		if key == controls["right"] then
			objects["player"][1]:moveRight(true)
		elseif key == controls["left"] then
			objects["player"][1]:moveLeft(true)
		end
	end

	if key == controls["jump"] then
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
	if objects["player"][1].frozen then
		return
	end

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

function gameNewDialog(speaker, text, continue, prompt)
	if #dialogs > 0 then
		table.remove(dialogs, 1)
	end
	table.insert(dialogs, dialog:new(speaker, text, continue, prompt))
end

function getScrollValue()
	return math.floor(scrollValues[objects["player"][1].screen][1])
end