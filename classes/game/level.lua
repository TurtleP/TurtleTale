level = class("level")

function level:initialize(layers, name, fade)
	self.data = require("data.maps." .. name)

	self.width = self.data.width * 16
	self.height = self.data.height * 16

	for _, v in pairs(self.data.layers) do
		if v.type == "objectgroup" then
			self:createEntities(layers, v.objects)
		end
	end

	self.tiles = love.graphics.newImage("data/maps/" .. name .. ".png")

	local background = "sky"
	if self.data.properties.background then
		background = self.data.properties.background
	end
	self.background = love.graphics.newImage("graphics/backgrounds/" .. background .. ".png")

	if self.data.properties.song then
		self.music = love.graphics.newSource("audio/music/" .. self.data.properties.song .. ".ogg")
	end

	self.nextMap = self.data.properties.next
	self.previousMap = self.data.properties.prev

	self.changeMap = false
	self.fade = fade or 0
end

function level:checkChangeBounds(game)
	local player = game.player

	if self.fade == 0 and not self.changeMap then
		if self.previousMap then
			if player.x < 0 then
				self:changeLevel(game, "prev")
			end
		end

		if self.nextMap then
			if player.x + player.width > self.width then
				self:changeLevel(game, "next")
			end
		end
	end
end

function level:changeLevel(game, link)
	self.newLevel = self.data.properties[link]:split(";")
	PLAYERSPAWN = {tonumber(self.newLevel[2]), tonumber(self.newLevel[3])}
	
	if link == "prev" then
		game.player:moveLeft(true)
	else
		game.player:moveRight(true)
	end

	game.player.freeze = true

	self.changeMap = true
end

function level:update(dt)
	if self.changeMap then
		self.fade = math.min(self.fade + dt, 1)
	else
		self.fade = math.max(self.fade - dt, 0)
	end

	if self.changeMap then
		if self.fade == 1 then
			state:change("game", self.newLevel[1], 1)
		end
	else
		local player = state:get("player")

		if self.fade > 0 then
			if player.leftkey and player.x < self.width - 32 then
				player:moveLeft(false)
			elseif player.rightkey and player.x > 32 then
				player:moveRight(false)
			end
			player.freeze = false
		end
	end
end

function level:createEntities(layers, objects)
	for k, v in pairs(objects) do
		if _G[v.name] then
			if v.name == "tile" then
				tile:new(layers[3], v.x, v.y, v.width, v.height)
			elseif v.name == "water" then
				water:new(layers[4], v.x, v.y, v.width, v.height)
			end
		else
			print(v.name .. " does not exist.")
		end
	end
end

function level:draw()
	for x = 1, math.ceil(self.width / self.background:getWidth()) do
		love.graphics.draw(self.background, (x - 1) * TOPSCREEN_WIDTH, 0)
	end

	love.graphics.draw(self.tiles)
end

function level:drawTransition()
	love.graphics.setColor(0, 0, 0, 255 * self.fade)
	love.graphics.rectangle("fill", self.x, self.y, TOPSCREEN_WIDTH, SCREEN_HEIGHT)
	
	love.graphics.setColor(255, 255, 255, 255)
end