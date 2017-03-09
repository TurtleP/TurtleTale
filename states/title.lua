function titleInit()
    --menu stuff below
	home = love.graphics.newImage("maps/home.png")

	love.graphics.setBackgroundColor(backgroundColors.midnight)

    clouds = {}
	for x = 1, 8 do
		clouds[x] = cloud:new(math.random(love.graphics.getWidth()), math.random(love.graphics.getHeight() * 0.05, love.graphics.getHeight() * 0.4), math.random(30, 35))
	end

	stars = {}
	for x = 1, 72 do
		stars[x] = {math.random(400), math.random(love.graphics.getHeight() * 0.8)}
	end

	files = {}
	for k = 1, 3 do
		files[k] = file:new(240 * 0.14 + (k - 1) * 64, k)
	end

	menuSelection = 1
	menuSelecitonTimer = 0

    titleFade = 0
    titleDoFade = false

	if not titleSong then
		titleSong = love.audio.newSource("audio/music/title.ogg")
		titleSong:setLooping(true)
	end
	
	titleSong:play()
	
	menuStart = false

	deleteMode = false
	deleteTimer = 0

	dialogs = {}
end

function titleUpdate(dt)
    for k, v in pairs(clouds) do
		v:update(dt)
	end

    if titleDoFade then
        titleFade = math.min(titleFade + 1.2 * dt, 1)

        if titleFade == 1 then
            files[menuSelection]:click()
        end
    end

	menuSelecitonTimer = menuSelecitonTimer + 12 * dt
	selectionQuadi = math.floor(menuSelecitonTimer % 8) + 1

	if deleteMode then
		deleteTimer = deleteTimer + 4 * dt
	end

	for k, v in ipairs(dialogs) do
		v:update(dt)

		if v.remove then
			table.remove(dialogs, k)
		end
	end
end

function titleDraw()
    love.graphics.setScreen("top")

	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.setDepth(ENTITY_DEPTH)

	love.graphics.draw(backgroundImages["home"][1], 0, 0)
	
	for k, v in ipairs(stars) do
	    love.graphics.rectangle("fill", v[1], v[2], 1, 1)
	end

	love.graphics.draw(backgroundImages["home"][2], 0, -16)

	tiled:renderBackground()

	love.graphics.draw(home, 0, 0)

	for k, v in ipairs(clouds) do
		v:draw()
	end

	for k, v in pairs(dialogs) do
		v:draw()
	end
	
	love.graphics.setDepth(NORMAL_DEPTH)

	love.graphics.setDepth(INTERFACE_DEPTH)

	love.graphics.draw(titleImage, love.graphics.getWidth() * 0.5 - titleImage:getWidth() / 2, love.graphics.getHeight() * 0.15)

	love.graphics.setDepth(NORMAL_DEPTH)

	love.graphics.setColor(0, 0, 0, 255 * titleFade)
    love.graphics.rectangle("fill", 0, 0, 400, 240)

	--BOTTOM SCREEN

	love.graphics.setScreen("bottom")

	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill", 0, 0, 320, 240)
	
	if not menuStart then
		love.graphics.setFont(menuFont)

		love.graphics.setColor(255, 255, 255, 255)

	
		love.graphics.print("TOUCH TO BEGIN", love.graphics.getWidth() * 0.5 - menuFont:getWidth("TOUCH TO BEGIN") / 2, love.graphics.getHeight() * 0.5 - menuFont:getHeight() / 2 + 4)
	else
		local color, heart = {255, 255, 255}, 1
		if math.floor(deleteTimer) % 2 ~= 0 then
			color, heart = {255, 0, 0}, 2
		end
				
		for k, v in ipairs(files) do
			love.graphics.setColor(128, 128, 128)
			if menuSelection == k then
				love.graphics.setColor(unpack(color))
			end
			
			v:draw()
		end
	end

    love.graphics.setColor(0, 0, 0, 255 * titleFade)
    love.graphics.rectangle("fill", 0, 0, 320, 240)
end

function titleKeyPressed(key)
    if not menuStart then
		menuStart = true
		return
	end

	if titleDoFade then
		return
	end
	
	if key == "down" then
		if menuSelection < 3 then
			selectionSound:play()
		end
		menuSelection = math.min(menuSelection + 1, 3)
	elseif key == "up" then
		if menuSelection > 1 then
			selectionSound:play()
		end
		menuSelection = math.max(menuSelection - 1, 1)
	elseif key == "a" then
		if not deleteMode then
       		titleDoFade = true
		else
			files[menuSelection]:delete()
		end
    elseif key == "rbutton" then
		deleteMode = not deleteMode

		if not deleteMode then
			deleteTimer = 0
		end
	elseif key == "select" then
		titleEnableCirclePad(not circlePadEnabled)
	end
end

function titleMousePressed(x, y, button)
    if not menuStart then
		menuStart = true
		return
	else
        for k, v in ipairs(files) do
            if v:inside(x, y) then
				menuSelection = k

				if menuSelection ~= k then
					selectionSound:play()
				else
					if not deleteMode then
						titleDoFade = true
					else
						files[menuSelection]:delete()
					end
				end
            end
        end
    end
end

function titleEnableCirclePad(enable)
	circlePadEnabled = enable

	if dialogs[1] then
		return
	end

	if enable then
		controls["right"] = "cpadright"
		controls["left"] = "cpadleft"
		controls["up"] = "cpadup"
		controls["down"] = "cpaddown"

		dialogs[1] = dialog:new("turtle", "The CIRCLE PAD has been enabled!")
	else
		controls["right"] = "right"
		controls["left"] = "left"
		controls["up"] = "up"
		controls["down"] = "down"

		dialogs[1] = dialog:new("turtle", "The CIRCLE PAD has been disabled!")
	end

	local path = "sdmc:/LovePotion/TurtleTale"

    if _EMULATEHOMEBREW then
        path = love.filesystem.getSaveDirectory() 
	end

	file = io.open(path .. "/save.lua", "a+")

	if file then
		file:seek("end")
		file:write(", " .. tostring(enable))
		file:close()
	end
end