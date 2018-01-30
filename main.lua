io.stdout:setvbuf("no")

class = require 'libraries.middleclass'
json = require 'libraries.json'

require 'libraries.functions'
require 'vars'

save = require 'libraries.save'
vector = require 'libraries.vector'
event = require 'libraries.event'

require 'libraries.physics'

love.graphics.setDefaultFilter("nearest", "nearest")

require 'classes.game.object'
require 'classes.game.entity'
require 'classes.game.level'

require 'classes.game.prefabs.userectangle'
require 'classes.game.prefabs.barrier'
require 'classes.game.prefabs.water'
require 'classes.game.prefabs.house'
require 'classes.game.prefabs.clock'
require 'classes.game.prefabs.bed'
require 'classes.game.prefabs.door'
require 'classes.game.prefabs.sign'
require 'classes.game.prefabs.palm'

require 'classes.game.effects.particle'
require 'classes.game.effects.smoke'
require 'classes.game.effects.hitbox'

require 'classes.game.enemies.fire'
require 'classes.game.enemies.phoenix'
require 'classes.game.enemies.hermit'
require 'classes.game.enemies.bat'
require 'classes.game.enemies.spider'
require 'classes.game.enemies.tardigrade'

require 'classes.game.entities.player'
require 'classes.game.entities.tile'
require 'classes.game.entities.health'
require 'classes.game.entities.shell'
require 'classes.game.entities.block'
require 'classes.game.entities.chest'
require 'classes.game.entities.key'
require 'classes.game.entities.button'

require 'classes.game.hud'
require 'classes.game.dialog'

require 'classes.game.shop.item'
shop = require 'classes.game.shop.shop'

state = require 'libraries.state'
achievements = require 'libraries.achievement'

reloadData()

require 'classes.gui'

function love.load()
	gameTilesImage = love.graphics.newImage("graphics/game/tiles.png")
	gameTilesQuads = {}
	for y = 1, gameTilesImage:getHeight() / 17 do
		for x = 1, gameTilesImage:getWidth() / 17 do
			table.insert(gameTilesQuads, love.graphics.newQuad((x - 1) * 17, (y - 1) * 17, 16, 16, gameTilesImage:getWidth(), gameTilesImage:getHeight()))
		end
	end

	bottomScreenImage = love.graphics.newImage("graphics/game/hud/shell.png")

	healthImage = love.graphics.newImage("graphics/game/hud/health.png")
	healthQuads = {}
	for x = 1, 4 do
		healthQuads[x] = love.graphics.newQuad((x - 1) * 8, 0, 8, 8, healthImage:getWidth(), healthImage:getHeight())
	end

	moneyImage = love.graphics.newImage("graphics/game/objects/money.png")
	moneyQuads = {}
	for x = 1, 2 do
		moneyQuads[x] = love.graphics.newQuad((x - 1) * 7, 0, 7, 6, moneyImage:getWidth(), moneyImage:getHeight())
	end
	table.insert(moneyQuads, love.graphics.newQuad(0, 6, 15, 10, moneyImage:getWidth(), moneyImage:getHeight()))

	clockImage = love.graphics.newImage("graphics/title/clock.png")
	buttonImage = love.graphics.newImage("graphics/game/hud/button.png")
	calendarImage = love.graphics.newImage("graphics/title/calendar.png")

	selectVerticalImage = love.graphics.newImage("graphics/game/select_vertical.png")
	selectVerticalQuads = {}
	for i = 1, 8 do
		selectVerticalQuads[i] = love.graphics.newQuad(0, (i - 1) * 5, 10, 5, selectVerticalImage:getWidth(), selectVerticalImage:getHeight())
	end

	selectHorizontalImage = love.graphics.newImage("graphics/game/select_horizontal.png")
	selectHorizontalQuads = {}
	for i = 1, 8 do
		selectHorizontalQuads[i] = love.graphics.newQuad((i - 1) * 5, 0, 5, 10, selectHorizontalImage:getWidth(), selectHorizontalImage:getHeight())
	end

	cloudImages = {}
	for i = 1, 4 do
		cloudImages[i] = love.graphics.newImage("graphics/title/cloud" .. i .. ".png")
	end

	batteryImage = love.graphics.newImage("graphics/game/hud/battery.png")
	
	bannerImage = love.graphics.newImage("graphics/title/title.png")

	fanfareSound = love.audio.newSource("audio/fanfare.ogg", "static")
	flyAwaySound = love.audio.newSource("audio/flyaway.ogg", "static")

	math.randomseed(os.time())

	gameFont = love.graphics.newFont("graphics/Gohu.10.ttf")
	love.graphics.setFont(gameFont)
	
	love.audio.setVolume(0)

	state:change("intro")

	love.graphics.setBackgroundColor(0, 0, 0)
end

function love.update(dt)
	achievements:update(dt)

	state:update(dt)
end

function love.draw()
	state:draw()

	achievements:draw()
end

function love.keypressed(key)
	if key == "lz" then
		love.event.quit()
	elseif key == "rz" then
		state:change("test")
	end

	state:keypressed(key)
end

function love.keyreleased(key)
	state:keyreleased(key)
end

function love.mousepressed(x, y, button)
	state:mousepressed(x, y, button)
end

function love.wheelmoved(x, y)
	state:wheelmoved(x, y)
end

require 'libraries.Horizon'