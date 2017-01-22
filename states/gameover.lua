function gameOverInit()
    love.audio.stop()
    
    phoenixObject = phoenix:new(love.graphics.getWidth() / 2, 80)

    gameOveri = 1

    gameOverSound:play()
end

function gameOverUpdate(dt)
    phoenixObject:update(dt)

    for k, v in ipairs(clouds) do
		v:update(dt)
	end
end

function gameOverDraw()
    love.graphics.setScreen("top")

    love.graphics.setColor(255, 255, 255, 255)

    for k, v in ipairs(clouds) do
		v:draw()
	end

    phoenixObject:draw()

    for k, v in pairs(gameOverImage) do
        love.graphics.setScreen(k)
        love.graphics.draw(v, love.graphics.getWidth() / 2 - v:getWidth() / 2, love.graphics.getHeight() - v:getHeight())
    end

    love.graphics.setScreen("bottom")

    love.graphics.setFont(menuFont)

    local color = {127, 127, 127}
    if gameOveri == 1 then
        color = {255, 255, 255}
    end
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Continue", love.graphics.getWidth() / 2 - menuFont:getWidth("Continue") / 2 - 1, love.graphics.getHeight() * 0.35 - 1)

    love.graphics.setColor(unpack(color))
    love.graphics.print("Continue", love.graphics.getWidth() / 2 - menuFont:getWidth("Continue") / 2, love.graphics.getHeight() * 0.35)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Quit", love.graphics.getWidth() / 2 - menuFont:getWidth("Quit") / 2 - 1, love.graphics.getHeight() * 0.65 - 1)
    
    local color = {127, 127, 127}
    if gameOveri == 2 then
        color = {255, 255, 255}
    end
    love.graphics.setColor(unpack(color))
    love.graphics.print("Quit", love.graphics.getWidth() / 2 - menuFont:getWidth("Quit") / 2, love.graphics.getHeight() * 0.65)
end

function gameOverKeyPressed(key)
    if key == "up" then
        gameOveri = math.max(gameOveri - 1, 1)
    elseif key == "down" then
        gameOveri = math.min(gameOveri + 1, 2)
    end

    if key == "a" then
        if gameOveri == 1 then
            files[saveManager:getCurrentSave()]:click()
        elseif gameOveri == 2 then
            util.changeState("title")
        end
    end
end