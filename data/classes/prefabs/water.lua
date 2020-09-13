local Entity = require("data.classes.entity")
local Water = Entity:extend()

Water.texture = love.graphics.newImage("graphics/prefabs/water.png")
Water.quads = {}

for i = 1, 3 do
    Water.quads[i] = love.graphics.newQuad((i - 1) * 32, 0, 32, 32, Water.texture)
end

function Water:new(x, y, width, height)
    Water.super.new(self, x, y, width, height)

    self.timer = 0
    self.quadi = 1
end

function Water:update(dt)
    self.timer = self.timer + 6 * dt
    self.quadi = math.floor(self.timer % #Water.quads) + 1
end

function Water:draw()
    for x = 1, math.floor(self.width / 32) do
        love.graphics.draw(Water.texture, Water.quads[self.quadi], self.x + (x - 1) * 32, self.y)
    end
end

function Water:static()
    return true
end

function Water:passive()
    return true
end

function Water:__tostring()
    return "water"
end

return Water