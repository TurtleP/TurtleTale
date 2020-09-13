local Entity = require("data.classes.entity")
local Trigger = Entity:extend()

function Trigger:new(x, y, height, properties)
    Trigger.super.new(self, x, y, 1, height)

    self.flags.fired = false
    self.flags.noDraw = true

    self.warp = properties.warp:split(";")
end

function Trigger:fire(entity)
    local x, y, w, h = entity:bounds()

    local direction = self.warp[4]

    local function canFire()
        if direction == "left" then
            return x + w / 2 < self.x + self.width
        end
        return x + w / 2 > self.x + self.width
    end

    if canFire() then
        if self.flags.fired then
            return
        end

        entity.flags.controlsDisabled = true

        local name, x, y = unpack(self.warp)

        tiled.transition(true, {0, 0, 0}, function()
            tiled.loadMap(name, tonumber(x), tonumber(y) - entity.height)

            entity.flags.controlsDisabled = false
            entity:move(direction, false)
        end)

        self.flags.fired = true
    end

end

function Trigger:static()
    return true
end

function Trigger:passive()
    return true
end

function Trigger:__tostring()
    return "trigger"
end

return Trigger