io.stdout:setvbuf("no")

require 'vars'
require 'libraries.functions'

class = require 'libraries.middleclass'
json = require 'libraries.json'
save = require 'libraries.save'
vector = require 'libraries.vector'

require 'libraries.physics'

love.graphics.setDefaultFilter("nearest", "nearest")


require 'classes.game.entity'
require 'classes.game.level'

require 'classes.game.particle'
require 'classes.game.player'
require 'classes.game.tile'
require 'classes.game.hud'
require 'classes.game.water'

state = require 'libraries.state'

require 'classes.gui'

function love.load()
	bottomScreenImage = love.graphics.newImage("graphics/hud/shell.png")

	healthImage = love.graphics.newImage("graphics/hud/health.png")
	healthQuads = {}
	for x = 1, 4 do
		healthQuads[x] = love.graphics.newQuad((x - 1) * 8, 0, 8, 8, healthImage:getWidth(), healthImage:getHeight())
	end

	moneyImage = love.graphics.newImage("graphics/game/money.png")
	moneyQuads = {}
	for x = 1, 2 do
		moneyQuads[x] = love.graphics.newQuad((x - 1) * 7, 0, 7, 6, moneyImage:getWidth(), moneyImage:getHeight())
	end
	table.insert(moneyQuads, love.graphics.newQuad(0, 6, 15, 10, moneyImage:getWidth(), moneyImage:getHeight()))

	clockImage = love.graphics.newImage("graphics/title/clock.png")
	buttonImage = love.graphics.newImage("graphics/hud/button.png")
	calendarImage = love.graphics.newImage("graphics/title/calendar.png")

	math.randomseed(os.time())

	gameFont = love.graphics.newFont("graphics/Gohu.10.ttf")
	
	love.audio.setVolume(0)

	state:change("title")
end

function love.update(dt)
	state:update(dt)
end

function love.draw()
	state:draw()
end

function love.keypressed(key)
	if key == "lz" then
		love.event.quit()
	end
	state:keypressed(key)
end

function love.keyreleased(key)
	state:keyreleased(key)
end

require 'libraries.Horizon'