local Entity = require("data.classes.entity")
local Clock = Entity:extend()

Clock.texture = love.graphics.newImage("graphics/prefabs/clock.png")
Clock.quads = {}

for i = 1, 3 do
    Clock.quads[i] = love.graphics.newQuad((i - 1) * 30, 0, 30, 64, Clock.texture)
end

function Clock:new(x, y)
    Clock.super.new(self, x, y, 30, 64)

    self.timer = 0
    self.quadi = 1

    self.animation = {1, 2, 3, 2}
end

function Clock:update(dt)
    self.timer = self.timer + 2 * dt
    self.quadi = self.animation[math.floor(self.timer % #self.animation) + 1]
end

function Clock:draw()
    love.graphics.draw(Clock.texture, Clock.quads[self.quadi], self.x, self.y)
end

function Clock:static()
    return true
end

function Clock:passive()
    return true
end

function Clock:__tostring()
    return "clock"
end

return Clock