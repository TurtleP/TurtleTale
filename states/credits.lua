local credits = class("credits")

function credits:load()
	self.speed = vector(30, 24)
	
	love.graphics.setBackgroundColor(22, 78, 122)

	self.music = love.audio.newSource("audio/music/phoenix.ogg", "stream")
	self.music:setLooping(true)
	self.music:play()

	self.background = love.graphics.newImage("graphics/backgrounds/sky.png")
	self.ground = love.graphics.newImage("data/maps/credits.png")

	self.player = state.states["game"].player

	self.player:setPosition(20, SCREEN_HEIGHT - 46)
	self.player:changeState("walk")
	self.player.static = true

	self.clouds = {}
	self.cloudTimer = 0
	self.cloudDelay = 0.5

	self.textFade = 0
	self.finishDelay = 1
	self.complete = false

	self.mapPosition = 0
end

function credits:update(dt)
	for i = 1, #CREDITS do
		CREDITS[i][3] = CREDITS[i][3] - self.speed.y * dt
	end

	self.player:update(dt)

	self.cloudTimer = self.cloudTimer + dt
	if self.cloudTimer > self.cloudDelay then
		table.insert(self.clouds, {index = math.random(1, 4), speed = math.random(30, 50), x = 320, y = math.random(SCREEN_HEIGHT * 0.4)})
		self.cloudDelay = math.random(1, 2)
		self.cloudTimer = 0
	end
	
	for i, v in ipairs(self.clouds) do
		v.x = v.x - v.speed * dt
		if v.x < -cloudImages[v.index]:getWidth() then
			table.remove(self.clouds, i)
		end
	end

	if CREDITS[#CREDITS][2] == "top" and not self.complete then
		self.player:moveRight(true)
		self.complete = true
	end

	if self.complete then
		self.finishDelay = self.finishDelay - dt
		if self.finishDelay < 0 and self.player.x > BOTSCREEN_WIDTH then
			self.textFade = math.min(self.textFade + dt, 1)
		end
	else
		self.mapPosition = self.mapPosition - self.speed.x * dt
	end
end

function credits:draw()
	love.graphics.setScreen("top")
	love.graphics.draw(bannerImage, (TOPSCREEN_WIDTH - bannerImage:getWidth()) / 2, (SCREEN_HEIGHT - bannerImage:getHeight()) / 2)

	love.graphics.setScreen("bottom")
	love.graphics.draw(self.background)

	for i = 1, #CREDITS do
		if CREDITS[i][3] + (i - 1) * 20 < -gameFont:getHeight() and CREDITS[i][2] == "bottom" then
			CREDITS[i][2] = "top"
		end

		love.graphics.setColor(0, 0, 0)
		love.graphics.print(CREDITS[i][1], (BOTSCREEN_WIDTH - gameFont:getWidth(CREDITS[i][1])) / 2 - 1, CREDITS[i][3] + (i - 1) * 20 - 1)
		
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(CREDITS[i][1], (BOTSCREEN_WIDTH - gameFont:getWidth(CREDITS[i][1])) / 2, CREDITS[i][3] + (i - 1) * 20)
	end

	love.graphics.setColor(0, 0, 0, 255 * self.textFade)
	love.graphics.print("END", (BOTSCREEN_WIDTH - gameFont:getWidth("END")) / 2 - 1, (SCREEN_HEIGHT - gameFont:getHeight()) / 2 - 1)

	love.graphics.setColor(255, 255, 255, 255 * self.textFade)
	love.graphics.print("END", (BOTSCREEN_WIDTH - gameFont:getWidth("END")) / 2, (SCREEN_HEIGHT - gameFont:getHeight()) / 2)

	love.graphics.setColor(255, 255, 255, 255)

	for i, v in ipairs(self.clouds) do
		love.graphics.draw(cloudImages[v.index], v.x, v.y)
	end

	for i = 1, math.ceil(self.ground:getWidth() / 320) do
		love.graphics.draw(self.ground, self.mapPosition + (i - 1) * self.ground:getWidth())
	end
	
	self.player:draw()
end

function credits:destroy()
	self.music = nil
	self.background = nil
	self.ground = nil
	self.player.static = false
end

return credits