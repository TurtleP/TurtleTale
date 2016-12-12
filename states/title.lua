function titleInit()
    --menu stuff below
	tiled:setMap("home")

	love.graphics.setBackgroundColor(backgroundColors.midnight)

    clouds = {}
	for x = 1, 6 do
		clouds[x] = cloud:new(math.random(love.graphics.getWidth()), math.random(love.graphics.getHeight() * 0.1, love.graphics.getHeight() * 0.2), math.random(30, 35))
	end

	stars = {}
	for x = 1, 40 do
		stars[x] = {math.random(love.graphics.getWidth()), math.random(love.graphics.getHeight() * 0.8)}
	end

	files = {}
	for k = 1, 3 do
		files[k] = file:new(240 * 0.14 + (k - 1) * 64, k)
	end

	menuSelection = 1
	menuSelecitonTimer = 0

    titleFade = 0
    titleDoFade = false

	titleSong:play()
	
	menuStart = false
end

function titleUpdate(dt)
    for k, v in pairs(clouds) do
		v:update(dt)
	end

    if titleDoFade then
        titleFade = math.min(titleFade + 0.6 * dt, 1)

        if titleFade == 1 then
            files[menuSelection]:click()
        end
    end

	menuSelecitonTimer = menuSelecitonTimer + 12 * dt
	selectionQuadi = math.floor(menuSelecitonTimer % 8) + 1
end

function titleDraw()
    love.graphics.setScreen("top")

	love.graphics.setColor(255, 255, 255, 255)

    for k, v in ipairs(stars) do
	    love.graphics.rectangle("fill", v[1], v[2], 1, 1)
	end

	for k, v in pairs(tiled:getTiles()) do
		v:draw()
	end

	for k, v in ipairs(clouds) do
		v:draw()
	end
	
	love.graphics.draw(titleImage, love.graphics.getWidth() * 0.5 - titleImage:getWidth() / 2, love.graphics.getHeight() * 0.15)

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
		love.graphics.setColor(255, 0, 0)
		love.graphics.draw(selectionImage, selectionQuads[selectionQuadi], love.graphics.getWidth() * 0.10 + math.cos(love.timer.getTime() * 8) * 2, (240 * 0.14) + (28 - selectionImage:getHeight() / 2) + (menuSelection - 1) * 64)
				
		for k, v in ipairs(files) do
			love.graphics.setColor(128, 128, 128)
			if menuSelection == k then
				love.graphics.setColor(255, 255, 255)
			end
			
			v:draw()
		end
	end
	
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(settingsImage, 4, 4)

    love.graphics.setColor(0, 0, 0, 255 * titleFade)
    love.graphics.rectangle("fill", 0, 0, 320, 240)
end

function titleKeyPressed(key)
    if not menuStart then
		menuStart = true
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
        titleDoFade = true
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
				end

                titleDoFade = true
            end
        end
    end
end