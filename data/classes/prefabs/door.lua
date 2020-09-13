local Interactive = require("data.classes.mixin.interactive")
local Door = Interactive:extend()

function Door:new(x, y, properties)
    Door.super.new(self, x, y, 32, 64)

    self.warp = properties.warp:split(";")
end

function Door:use(entity)
    if self:inUse() then
        return
    end

    tiled.transition(true, {0, 0, 0}, function()
        tiled.loadMap(self.warp[1], tonumber(self.warp[2]), tonumber(self.warp[3]))
    end)

    entity:useEntity(false)
    self.flags.inUse = true
end

function Door:static()
    return true
end

function Door:passive()
    return true
end

function Door:__tostring()
    return "door"
end

return Door