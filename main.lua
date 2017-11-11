love.graphics.setDefaultFilter("nearest", "nearest")

io.stdout:setvbuf("no")

tiled = require 'libraries.tiled'
class = require 'libraries.middleclass'
util = require 'libraries.util'
require 'libraries.physics'
require 'libraries.event'
json = require 'libraries.json'

require 'libraries.gui'
require 'states.test' -- out of sight

require 'values'
LOAD_EVENTS()

saveManager = require 'libraries.savemanager'
saveManager:init()

require 'classes.entity'
require 'classes.file'
require 'classes.hud'
require 'classes.inventory'
require 'classes.dialog'
require 'classes.shopmenu'
require 'classes.item'

require 'classes.entities.chest'
require 'classes.entities.smoke'
require 'classes.entities.crate'
require 'classes.entities.barrier'
require 'classes.entities.tile'
require 'classes.entities.bird'
require 'classes.entities.health'
require 'classes.entities.coin'
require 'classes.entities.turtle'
require 'classes.entities.shopkeeper'
require 'classes.entities.sign'
require 'classes.entities.block'
require 'classes.entities.container'

require 'classes.enemies.ai'
require 'classes.enemies.fish'
require 'classes.enemies.phoenix'
require 'classes.enemies.hermit'
require 'classes.enemies.spider'
require 'classes.enemies.bat'
require 'classes.enemies.fireball'

require 'classes.enemies.boss.batboss'
require 'classes.enemies.boss.hermitboss'

require 'classes.prefabs.cloud'
require 'classes.prefabs.door'
require 'classes.prefabs.clock'
require 'classes.prefabs.bed'
require 'classes.prefabs.palm'
require 'classes.prefabs.trigger'
require 'classes.prefabs.water'
require 'classes.prefabs.home'
require 'classes.prefabs.userectangle'
require 'classes.prefabs.key'
require 'classes.prefabs.bossdoor'
require 'classes.prefabs.rock'

require 'states.title'
require 'states.game'
require 'states.intro'
require 'states.gameover'

version = "1.0"

function love.load()
	backgroundColors = 
	{
		["midnight"] = {16, 51, 90},
		["sky"] = {107,161,228},
		["indoors"] = {43, 19, 23}
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

	healthImage = love.graphics.newImage("graphics/hud/health.png")
	healthQuads = {}
	for k = 1, 4 do
		healthQuads[k] = love.graphics.newQuad((k - 1) * 8, 0, 8, 8, healthImage:getWidth(), healthImage:getHeight())
	end

	phoenixImage = love.graphics.newImage("graphics/game/enemies/phoenix.png")
	phoenixQuads = {}
	for y = 1, 2 do
		for x = 1, 3 do
			table.insert(phoenixQuads, love.graphics.newQuad((x - 1) * 77, (y - 1) * 50, 77, 50, phoenixImage:getWidth(), phoenixImage:getHeight()))
		end
	end

	bedImage = love.graphics.newImage("graphics/game/prefabs/bed.png")
	bedQuads = {}
	for y = 1, 5 do
		bedQuads[y] = love.graphics.newQuad(0, (y - 1) * 17, 32, 17, bedImage:getWidth(), bedImage:getHeight())
	end

	clockImage = love.graphics.newImage("graphics/game/prefabs/clock.png")
	clockQuads = {}
	for i = 1, 3 do
		clockQuads[i] = love.graphics.newQuad((i - 1) * 15, 0, 15, 32, clockImage:getWidth(), clockImage:getHeight())
	end

	bookImage = love.graphics.newImage("graphics/game/savegame.png")
	bookQuads = {}
	for x = 1, 10 do
		bookQuads[x] = love.graphics.newQuad((x - 1) * 32, 0, 32, 32, bookImage:getWidth(), bookImage:getHeight())
	end
	bookTimer = 0
	bookQuadi = 1
	bookFade = 1

	chestImage = love.graphics.newImage("graphics/game/chest.png")
	chestQuads = {}
	for i = 1, 5 do
		chestQuads[i] = love.graphics.newQuad((i - 1) * 32, 0, 32, 32, chestImage:getWidth(), chestImage:getHeight())
	end

	crateImage = love.graphics.newImage("graphics/game/crate.png")
	crateQuads = {}
	for i = 1, 5 do
		crateQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, crateImage:getWidth(), crateImage:getHeight())
	end

	introImage = love.graphics.newImage("graphics/intro/intro.png")
	siteImage = love.graphics.newImage("graphics/intro/site.png")

	palmTreeImage = love.graphics.newImage("graphics/game/prefabs/palm_tree.png")
	palmTreeQuads = {}
	for i = 1, 5 do
		palmTreeQuads[i] = love.graphics.newQuad((i - 1) * 32, 0, 32, 32, palmTreeImage:getWidth(), palmTreeImage:getHeight())
	end

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

	waterImage = love.graphics.newImage("graphics/game/prefabs/water.png")
	waterQuads = {}
	for i = 1, waterImage:getWidth() / 17 do
		waterQuads[i] = love.graphics.newQuad((i - 1) * 17, 0, 16, 16, waterImage:getWidth(), waterImage:getHeight())
	end

	batteryImage = love.graphics.newImage("graphics/hud/battery.png")

	backgroundImages = 
	{
		["home"] = 
		{
			love.graphics.newImage("graphics/backgrounds/home_sky.png"), 
			love.graphics.newImage("graphics/backgrounds/home_mountains.png"), 
		},
		["sky"] = love.graphics.newImage("graphics/backgrounds/sky.png"),
	}

	lightBaseImage = love.graphics.newImage("graphics/gameover/light_base.png")
	inventoryImage = love.graphics.newImage("graphics/hud/inventory.png")

	inventoryIcons = love.graphics.newImage("graphics/hud/icons_new.png")
	inventoryIconQuads = {}
	for i = 1, 4 do
		inventoryIconQuads[i] = love.graphics.newQuad((i - 1) * 16, 0, 16, 16, inventoryIcons:getWidth(), inventoryIcons:getHeight())
	end

	introSound = love.audio.newSource("audio/jingle.ogg")
	
	jumpSound = love.audio.newSource("audio/jump.ogg")
	selectionSound = love.audio.newSource("audio/select.ogg")
	dialogSound = love.audio.newSource("audio/dialog.ogg")
	gameOverSound = {love.audio.newSource("audio/music/gameover_start.ogg"), love.audio.newSource("audio/music/gameover.ogg")}
	gameOverSound[2]:setLooping(true)

	duckSound = love.audio.newSource("audio/duck.ogg")
	pitDeathSound = love.audio.newSource("audio/pit.ogg")
	chargeSound = love.audio.newSource("audio/charge.ogg")
	poofSound = love.audio.newSource("audio/poof.ogg")
	punchSound = love.audio.newSource("audio/punch.ogg")
	batChaseSound = love.audio.newSource("audio/bat_distress.ogg")
	batIdleSound = {love.audio.newSource("audio/bat_pitchup.ogg"), love.audio.newSource("audio/bat_pitchdown.ogg")}
	healthPickup = love.audio.newSource("audio/eatup.ogg")
	flyAwaySound = love.audio.newSource("audio/flyaway.ogg")
	purchaseSound = love.audio.newSource("audio/purchase.ogg")
	fanfareSound = love.audio.newSource("audio/itemget.ogg")
	coinPickupSound = love.audio.newSource("audio/coin.ogg")

	loadFont()

	math.randomseed(os.time())
	math.random()
	math.random()

	objects = {}

	tiled:cacheMaps()
	
	INTERFACE_DEPTH = 4
	ENTITY_DEPTH = 2
	NORMAL_DEPTH = 0

	gameClouds =
	{
		["indoors"] = false,
		["shop_beach"] = false
	}

	love.graphics.set3D(true)

	util.changeState("intro")
end

function love.update(dt)
	dt = math.min(1/60, dt)

	util.updateState(dt)

	if savingData then
		if bookQuadi < #bookQuads then
			bookTimer = bookTimer + 10 * dt
			bookQuadi = math.floor(bookTimer % #bookQuads) + 1
		else
			bookFade = math.max(bookFade - dt, 0)
			if bookFade <= 0 then
				savingData = false
				bookTimer = 0
				bookQuadi = 1
				bookFade = 1
			end
		end
	end
end

function love.draw()
	util.renderState()

	love.graphics.setScreen("top")

	if savingData then
		love.graphics.setColor(255, 255, 255, 255 * bookFade)
		love.graphics.draw(bookImage, bookQuads[bookQuadi], util.getWidth() - 40, util.getHeight() - 40)
		love.graphics.setColor(255, 255, 255, 255)
	end

	--[[love.graphics.setScreen("bottom")
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(love.timer.getFPS(), love.graphics.getWidth() - gameFont:getWidth(love.timer.getFPS()), util.getHeight() - gameFont:getHeight())]]
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

require 'libraries.Horizon'
require 'errhand'