local gameover = class("gameover")

function gameover:load()
	love.audio.stop()

	self.start = love.audio.newSource("audio/music/gameover_start.ogg", "static")
	self.loop = love.audio.newSource("audio/music/gameover.ogg", "static")
	
	self.loop:setLooping(true)

	self.player = state.states["game"].player

	self.player:setPosition((TOPSCREEN_WIDTH - self.player.width) / 2, SCREEN_HEIGHT * 0.75)
	self.player:setState("dead")

	self.start:play()

	local map = state.states["game"].map
	map.changeMap = true

	self.light = love.graphics.newImage("graphics/gameover/light_base.png")

	self.ghostImage = love.graphics.newImage("graphics/gameover/turtle_ghost.png")
	self.ghostQuads = {}
	for i = 1, 4 do
		self.ghostQuads[i] = love.graphics.newQuad((i - 1) * 12, 0, 12, 20, self.ghostImage:getWidth(), self.ghostImage:getHeight())
	end

	self.ghostFade = 0
	self.ghostPosition = vector(self.player.x + (self.player.width - 12) / 2, self.player.y)
	
	self.ghostQuadi = 1
	self.ghostTimer = 0

	self.intro = false

	self.gui = 
	{
		imagebutton:new(buttonImage, "A", "Continue Game", 0, SCREEN_HEIGHT * 0.35, 192, 12, {padding = 2, offset = vector(BOTSCREEN_WIDTH, 0), center = true, func = function()
			save:getActiveFile():select()
		end}),

		imagebutton:new(buttonImage, "B", "Give Up", 0, SCREEN_HEIGHT * 0.6, 192, 12, {padding = 2, offset = vector(BOTSCREEN_WIDTH, 0), center = true, func = function()
			state:change("title")
		end})
	}
end

function gameover:update(dt)
	state.states["game"].map:update(dt)

	self.player:update(dt)

	if not self.start:isPlaying() then
		if not self.intro then
			self.loop:play()
			self.intro = true
		end
	end

	self.ghostFade = math.min(self.ghostFade + dt, 1)
	self.ghostPosition.y = math.max(self.ghostPosition.y - 48 * dt, self.player.y - 24)
	
	self.ghostTimer = self.ghostTimer + 6 * dt
	self.ghostQuadi = math.floor(self.ghostTimer % 4) + 1
end

function gameover:draw()
	love.graphics.setScreen("top")
	
	love.graphics.push()
	
	love.graphics.translate(-state.states["game"].camera.x, 0)
	
	state.states["game"].map:draw()
	
	love.graphics.pop()
	
	state.states["game"].map:drawTransition()
	
	love.graphics.print("GAME OVER", (TOPSCREEN_WIDTH - gameFont:getWidth("GAME OVER")) / 2, SCREEN_HEIGHT * 0.25)
	love.graphics.print("YOU HAVE DIED.", (TOPSCREEN_WIDTH - gameFont:getWidth("YOU HAVE DIED")) / 2, SCREEN_HEIGHT * 0.35)
	
	love.graphics.setColor(255, 255, 255, 255 * self.ghostFade)
	love.graphics.draw(self.ghostImage, self.ghostQuads[self.ghostQuadi], self.ghostPosition.x, self.ghostPosition.y)

	love.graphics.setScreen("bottom")

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, BOTSCREEN_WIDTH, SCREEN_HEIGHT)

	love.graphics.setColor(255, 255, 255)
	for k, v in ipairs(self.gui) do
		v:draw()
	end
end

function gameover:keypressed(key)
	for i, v in ipairs(self.gui) do
		v:keypressed(key)
	end
end

function gameover:destroy()
	self.start = nil
	self.loop:stop()
	self.loop = nil

	self.player:setState("idle")
	self.player.freeze = false
end

return gameover