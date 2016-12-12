io.stdout:setvbuf("no")

_EMULATEHOMEBREW = (love.system.getOS() ~= "3ds")

function love.load()
	tiled = require 'libraries.tiled'
	class = require 'libraries.middleclass'
	util = require 'libraries.util'

	require 'values'
	
	require 'libraries.physics'
	require 'libraries.event'
	
	saveManager = require 'libraries.savemanager'
	saveManager:init()
	
	require 'classes.file'
	require 'classes.prefabs.cloud'
	require 'classes.turtle'
	require 'classes.tile'
	require 'classes.hud'
	require 'classes.barrier'
	require 'classes.prefabs.door'
	require 'classes.dialog'
	require 'classes.prefabs.clock'
	require 'classes.phoenix'
	require 'classes.pause'
	require 'classes.prefabs.bed'

	require 'states.title'
	require 'states.game'

	backgroundColors = 
	{
		["midnight"] = {16, 51, 90},
		["sky"] = {107,161,228}
	}

	gameTiles = love.graphics.newImage("graphics/tiles.png")
	tileQuads = {}
	for y = 1, gameTiles:getHeight() / 17 do
		for x = 1, gameTiles:getWidth() / 17 do
			table.insert(tileQuads, love.graphics.newQuad((x - 1) * 17, (y - 1) * 17, 16, 16, gameTiles:getWidth(), gameTiles:getHeight()))
		end
	end

	cloudImages = {}
	for k = 1, 4 do
		cloudImages[k] = love.graphics.newImage("graphics/game/cloud" .. k .. ".png")
	end

	titleImage = love.graphics.newImage("graphics/title.png")

	settingsImage = love.graphics.newImage("graphics/settings.png")

	selectionImage = love.graphics.newImage("graphics/select.png")
	selectionQuadi = 1
	selectionQuads = {}
	for x = 1, 8 do
		selectionQuads[x] = love.graphics.newQuad((x - 1) * 5, 0, 5, 10, selectionImage:getWidth(), selectionImage:getHeight())
	end

	selectionVerImage = love.graphics.newImage("graphics/selectver.png")
	selectionVerQuads = {}
	for y = 1, 8 do
		selectionVerQuads[y] = love.graphics.newQuad(0, (y - 1) * 5, 10, 5, selectionVerImage:getWidth(), selectionVerImage:getHeight())
	end

	turtleImage = love.graphics.newImage("graphics/player/turtle.png")
	turtleQuads = {}
	turtleAnimations = { {"idle", 4}, {"walk", 4}, {"jump", 3}, {"punch", 4}, {"dead", 6}, {"ledge", 4}, {"climb", 6} }

	for y = 1, #turtleAnimations do
		turtleQuads[turtleAnimations[y][1]] = {}
		for x = 1, turtleAnimations[y][2] do
			table.insert(turtleQuads[turtleAnimations[y][1]], love.graphics.newQuad((x - 1) * 12, (y - 1) * 20, 12, 20, turtleImage:getWidth(), turtleImage:getHeight()))
		end
	end

	dialogImage =
	{
		["turtle"] = love.graphics.newImage("graphics/dialog/turtle.png"),
		["phoenix"] = love.graphics.newImage("graphics/dialog/phoenix.png")
	}

	healthImage = love.graphics.newImage("graphics/hud/health.png")
	healthQuads = {}
	for k = 1, 2 do
		healthQuads[k] = love.graphics.newQuad((k - 1) * 8, 0, 8, 8, healthImage:getWidth(), healthImage:getHeight())
	end

	phoenixImage = love.graphics.newImage("graphics/game/phoenix.png")
	phoenixQuads = {}
	for y = 1, 2 do
		for x = 1, 3 do
			table.insert(phoenixQuads, love.graphics.newQuad((x - 1) * 77, (y - 1) * 50, 77, 50, phoenixImage:getWidth(), phoenixImage:getHeight()))
		end
	end

	bedImage = love.graphics.newImage("graphics/game/bed.png")
	bedQuads = {}
	for y = 1, 5 do
		bedQuads[y] = love.graphics.newQuad(0, (y - 1) * 17, 32, 17, bedImage:getWidth(), bedImage:getHeight())
	end

	clockImage = love.graphics.newImage("graphics/game/prefabs/clock.png")
	clockQuads = {}
	for i = 1, 3 do
		clockQuads[i] = love.graphics.newQuad((i - 1) * 15, 0, 15, 32, clockImage:getWidth(), clockImage:getHeight())
	end
	
	fireImage = love.graphics.newImage("graphics/game/fire.png")
	fireQuads = {}
	for i = 1, 5 do
		fireQuads[i] = love.graphics.newQuad((i - 1) * 8, 0, 8, 8, fireImage:getWidth(), fireImage:getHeight())
	end

	jumpSound = love.audio.newSource("audio/jump.ogg")
	selectionSound = love.audio.newSource("audio/select.ogg")
	dialogSound = love.audio.newSource("audio/dialog.ogg")
	
	titleSong = love.audio.newSource("audio/title.ogg")
	titleSong:setLooping(true)
	
	menuFont = love.graphics.newFont("graphics/PressStart2P.ttf", 16)
	smallFont = love.graphics.newFont("graphics/PressStart2P.ttf", 8)
	
	math.randomseed(os.time())
	math.random()
	math.random()

	scale = 1

	tiled:cacheMaps()

	currentScript = 1

	controls =
	{
		["left"] = "left",
		["right"] = "right",
		["up"] = "up",
		["down"] = "down",
		["jump"] = "a",
		["punch"] = "b"
	}
	
	SPAWN_X, SPAWN_Y = 1, 1
	
	cutscenes = {}
	for i = 1, 2 do
		cutscenes[i] = {require('scenes.' .. i), false}
	end

	util.changeState("title")
end

function love.update(dt)
	dt = math.min(0.1666667, dt)

	util.updateState(dt)
end

function love.draw()
	util.renderState()

	love.graphics.setScreen("top")
	love.graphics.setFont(smallFont)

	love.graphics.setColor(0, 0, 0)
	love.graphics.print(love.timer.getFPS(), 384, 6)

	love.graphics.setColor(255, 255, 255)
	love.graphics.print(love.timer.getFPS(), 385, 7)

	love.graphics.setScreen("bottom")
	love.graphics.setColor(64, 64, 64)
	love.graphics.rectangle("fill", -40, 0, 40, 240)
	love.graphics.rectangle("fill", 320, 0, 40, 240)
end

function love.keypressed(key)
	util.keyPressedState(key)
end

function love.keyreleased(key)
	util.keyReleasedState(key)
end

function love.mousepressed(x, y, button)
	util.mousePressedState(x, y, button)
end

function saveData()
	local file = io.open("save.txt", "w")
	
	local str = "1:\n2:\n3:\n"
	
	if file then
		file:write(str)
		file:flush()
		file:close()
	end
end

if _EMULATEHOMEBREW then
	require 'libraries.3ds'
end