function gameOverInit()
	love.graphics.setBackgroundColor(0, 0, 0)
	love.audio.stop()

	gameOverSound[1]:play()
	gameOverIntro = false

	turtleQuadi = 1

	gameOverFade = 1

	objects["player"][1].x = 200 - objects["player"][1].width / 2
	objects["player"][1].y = 192

	gameOverSelection = 1

	turtleGhosti = 1
	turtleGhostImage = love.graphics.newImage("graphics/gameover/turtle_ghost.png")
	turtleGhostQuads = {}
	for i = 1, 4 do
		table.insert(turtleGhostQuads, love.graphics.newQuad((i - 1) * 12, 0, 12, 20, turtleGhostImage:getWidth(), turtleGhostImage:getHeight()))
	end

	turtleGhostTimer = 0
	turtleGhostFade = 0

	turtleGhostLocation = 192

	gameOverState = 1
	gameOverButtons =
	{
		newButton(love.graphics.getHeight() * 0.35, "A", "Continue", function() gameOverState = 2 end),
		newButton(love.graphics.getHeight() * 0.65, "B", "Give Up ", function() gameOverState = 3 end)
	}
end

function gameOverUpdate(dt)
	gameOverFade = math.max(gameOverFade - dt / 0.8, 0)
	objects["player"][1]:update(dt)

	if not gameOverSound[1]:isPlaying() then
		if not gameOverIntro then
			gameOverSound[2]:play()
			gameOverIntro = true
		end

		if gameOverState == 1 then
			turtleGhostFade = math.min(turtleGhostFade + dt, 1)
			turtleGhostLocation = math.max(turtleGhostLocation - 32 * dt, 170)
		elseif gameOverState == 2 then
			turtleGhostLocation = turtleGhostLocation + 32 * dt
			turtleGhostFade = math.max(turtleGhostFade - dt, 0)

			if turtleGhostLocation >= objects["player"][1].y + 20 and turtleGhostFade == 0 then
				files[saveManager:getCurrentSave()]:click()
				gameOverSound[2]:stop()
			end
		elseif gameOverState == 3 then
			turtleGhostLocation = turtleGhostLocation - 32 * dt
			turtleGhostFade = math.max(turtleGhostFade - dt / 0.8, 0)

			if turtleGhostFade == 0 and turtleGhostLocation < 150 then
				util.changeState("title")
				gameOverSound[2]:stop()
			end
		end
	end
	turtleGhostTimer = turtleGhostTimer + 6 * dt
	turtleGhosti = math.floor(turtleGhostTimer % 4) + 1
end

function gameOverDraw()
	love.graphics.setScreen('top')

	love.graphics.setColor(255, 255, 255, 255 * gameOverFade)

	love.graphics.push()

	love.graphics.translate(-math.floor(mapScroll), 0)

	love.graphics.setScissor(unpack(currentScissor))

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

	love.graphics.setScissor()

	love.graphics.pop()

	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.draw(lightBaseImage, (objects["player"][1].x + objects["player"][1].width / 2) - 32, objects["player"][1].y + objects["player"][1].height - 2)

	objects["player"][1]:draw()

	love.graphics.setColor(255, 255, 255, 255 * turtleGhostFade)
	love.graphics.draw(turtleGhostImage, turtleGhostQuads[turtleGhosti], (objects["player"][1].x + objects["player"][1].width / 2) - 6, turtleGhostLocation)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("GAME OVER", love.graphics.getWidth() / 2 - gameFont:getWidth("GAME OVER") / 2, love.graphics.getHeight() * 0.35)

	love.graphics.setScreen("bottom")
	
	for k, v in ipairs(gameOverButtons) do
		v:draw()
	end
end

function gameOverKeyPressed(key)
	if turtleGhostFade ~= 1 then
		return
	end

	for k, v in ipairs(gameOverButtons) do
		if v.button:lower() == key then
			v.func()
		end
	end
end

function newButton(y, buttonName, text, func)
	local button = {}

	button.x = 160 - gameFont:getWidth(text) / 2 - 8
	button.y = y

	button.button = buttonName --button, button, who's got the button?
	button.text = text
	button.func = func

	function button:draw()
		love.graphics.circle("line", self.x, self.y, 8)
		love.graphics.print(self.button, self.x - 4, self.y - 8)

		love.graphics.print(self.text, self.x + 32, self.y - 7)
	end

	return button
end