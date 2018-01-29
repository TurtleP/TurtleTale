local title = class("title")

local star = require 'classes.title.star'

function title:load()
	self.topImage = love.graphics.newImage("graphics/title/home.png")
	
	self.backgroundImage = 
	{
		love.graphics.newImage("graphics/backgrounds/home_sky.png"),
		love.graphics.newImage("graphics/backgrounds/home_mountains.png")
	}

	self.stars = {}
	for x = 1, 80 do
		self.stars[x] = star:new(math.random(1, 399), math.random(SCREEN_HEIGHT * 0.8))
	end

	self.music = love.audio.newSource("audio/music/title.ogg", "stream")
	self.music:setLooping(true)
	self.music:play()

	self.timer = 0
	self.showFiles = true

	self.files = save:getFiles()
	self.selection = 1

	self.files[self.selection].selected = true

	self.gui =
	{
		imagebutton:new(buttonImage, "x", "Delete File", 0, SCREEN_HEIGHT * 0.85, 192, 12, {offset = vector(BOTSCREEN_WIDTH, 0), padding = 2, center = true, func = function()
			self.files[self.selection]:delete()
		end})
	}
end

function title:update(dt)
	self.timer = self.timer + dt

	for i, v in ipairs(self.stars) do
		v:update(dt)
	end
end

function title:draw()
	love.graphics.setScreen("top")

	love.graphics.draw(self.backgroundImage[1], 0, -16)
	
	for i, v in ipairs(self.stars) do
		v:draw()
	end

	love.graphics.draw(self.backgroundImage[2], 0, -16)

	love.graphics.draw(self.topImage)

	love.graphics.draw(bannerImage, (TOPSCREEN_WIDTH - bannerImage:getWidth()) / 2, SCREEN_HEIGHT * 0.15)

	love.graphics.setScreen("bottom")

	love.graphics.setColor(200, 200, 200)
	love.graphics.draw(bottomScreenImage)

	if not self.showFiles then
		if math.floor(self.timer) % 2 ~= 0 then
			return
		end
		
		love.graphics.print("TOUCH TO BEGIN", (BOTSCREEN_WIDTH - gameFont:getWidth("TOUCH TO BEGIN")) / 2, (SCREEN_HEIGHT - gameFont:getHeight()) / 2)
	else
		for j, w in pairs(self.files) do
			w:draw()
		end

		for k, v in ipairs(self.gui) do
			v:draw()
		end
	end
end

function title:keypressed(key)
	self.files[self.selection].selected = false

	if key == "down" then
		self.selection = math.min(self.selection + 1, #self.files)
	elseif key == "up" then
		self.selection = math.max(self.selection - 1, 1)
	end

	self.files[self.selection].selected = true

	for j, w in ipairs(self.files) do
		if self.selection == w.ID then
			w:keypressed(key)
		end
	end

	for i, v in ipairs(self.gui) do
		v:keypressed(key)
	end
end

function title:destroy()
	self.topImage = nil
	self.backgroundImage = nil
	self.stars = nil

	self.music:stop()
	self.music = nil
end

return title