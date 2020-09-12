local Entity = require("data.classes.entity")
local Tile = Entity:extend()

function Tile:new(x, y, width, height)
    Tile.super.new(self, x, y, width, height)
    self.flags.noDraw = true
end

function Tile:static()
    return true
end

function Tile:__tostring()
    return "tile"
end

return Tile