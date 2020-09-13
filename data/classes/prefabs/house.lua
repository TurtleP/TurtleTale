local Entity = require("data.classes.entity")
local House = Entity:extend()

House.texture = love.graphics.newImage("graphics/prefabs/house.png")
House.quads = {}

for i = 1, 2 do
    House.quads[i] = love.graphics.newQuad(0, (i - 1) * 96, 256, 96, House.texture)
end

function House:new(x, y)
    House.super.new(self, x, y, 256, 96)

    self.quadi = 1
end

function House:draw()
    love.graphics.draw(House.texture, House.quads[self.quadi], self.x, self.y)
end

function House:static()
    return true
end

function House:passive()
    return true
end

function House:__tostring()
    return "house"
end

return House