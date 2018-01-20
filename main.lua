io.stdout:setvbuf("no")

require 'vars'
require 'libraries.functions'

class = require 'libraries.middleclass'
json = require 'libraries.json'
save = require 'libraries.save'

require 'classes.game.entity'
require 'classes.game.player'

state = require 'libraries.state'

love.graphics.setDefaultFilter("nearest", "nearest")

function love.load()
	bottomScreenImage = love.graphics.newImage("graphics/hud/shell.png")

	math.randomseed(os.time())

	gameFont = love.graphics.newFont("graphics/Gohu.10.ttf")
	
	state:change("title")
end

function love.update(dt)
	state:update(dt)
end

function love.draw()
	state:draw()
end

function love.keypressed(key)
	state:keypressed(key)
end

function love.keyreleased(key)

end

require 'libraries.Horizon'