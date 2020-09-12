local Entity = require("data.classes.entity")
local Border = Entity:extend()

function Border:new(x, y, width, height)
    Border.super.new(self, x, y, width, height)
    self.flags.noDraw = true
end

function Border:static()
    return true
end

function Border:__tostring()
    return "border"
end

return Border