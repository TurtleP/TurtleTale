local nest = require("libraries.nest").init("hac")

love.graphics.setDefaultFilter("nearest", "nearest")

fonts = require("data.fonts")
state = require("libraries.state")
utility = require("libraries.utility")

function love.load()
    state.switch("game", "house")
end

function love.update(dt)
    state.update(dt)
end

function love.draw()
    state.draw()
end

function love.gamepadpressed(joy, button)
    state.gamepadpressed(joy, button)
end

function love.gamepadreleased(joy, button)
    state.gamepadreleased(joy, button)
end

function love.gamepadaxis(joy, axis, value)
    state.gamepadaxis(joy, axis, value)
end