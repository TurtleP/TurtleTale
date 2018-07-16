local intro = class("intro")

function intro:load()
	self.fade = 0
	self.timer = 0

	self.jingle = love.audio.newSource("audio/jingle.ogg", "static")
	self.jingle:play()

	self.logoImage = love.graphics.newImage("graphics/intro/logo.png")
	self.siteImage = love.graphics.newImage("graphics/intro/site.png")
end

function intro:update(dt)
	self.timer = self.timer + dt
	if self.timer < 2 then
		self.fade = math.min(self.fade + 0.6 * dt, 1)
	end

	if self.timer > 4 then
		state:change("title")
	elseif self.timer > 2 then
		self.fade = math.max(self.fade - 0.6 * dt, 0)
	end
end

function intro:draw()
	love.graphics.setScreen("top")
	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.draw(self.logoImage, (TOPSCREEN_WIDTH - self.logoImage:getWidth()) / 2, (SCREEN_HEIGHT - self.logoImage:getHeight()) / 2)

	love.graphics.draw(self.siteImage, TOPSCREEN_WIDTH - self.siteImage:getWidth(), SCREEN_HEIGHT - self.siteImage:getHeight())
end

function intro:destroy()
	self.logoImage = nil
	self.siteImage = nil
	self.jingle = nil
end

return intro