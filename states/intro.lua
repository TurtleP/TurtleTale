function introInit()
	introFade = 0
	introTimer = 0

	introSound:play()
end

function introUpdate(dt)
	introTimer = introTimer + dt
	if introTimer < 2 then
		introFade = math.min(introFade + 0.6 * dt, 1)
	end

	if introTimer > 4 then
		util.changeState("title")
		introTimer = 0
	elseif introTimer > 2 then
		introFade = math.max(introFade - 0.6 * dt, 0)
	end
end

function introDraw()
	love.graphics.setScreen("top")
	love.graphics.setColor(255, 255, 255, 255 * introFade)
	love.graphics.draw(introImage, util.getWidth() / 2 - introImage:getWidth() / 2, util.getHeight() / 2 - introImage:getHeight() / 2)

	love.graphics.draw(siteImage, util.getWidth() - siteImage:getWidth(), util.getHeight() - siteImage:getHeight())
end