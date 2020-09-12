local Object = require("libraries.classic")
local Entity = Object:extend()

local Vector = require("libraries.vector")

function Entity:new(x, y, width, height)
    self.x = x
    self.y = y

    self.width = width
    self.height = height

    self.speed = Vector()

    self.flags = {}

    -- DEFAULT FLAGS
    self.flags.passive = false
    self.flags.remove  = false
    self.flags.static  = false
    self.flags.frozen  = false
end

function Entity:update(dt)

end

function Entity:draw()
    if not self.flags.noDraw then
        error("Entity.draw not implemented!")
    end
end

function Entity:debugDraw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", unpack(self:bounds()))
end

function Entity:filter()
    return function(entity, other)
        if other:passive() then
            return false
        end
        return "slide"
    end
end

function Entity:is(name)
    return tostring(self) == name
end

function Entity:setVelocity(x, y)
    if type(x) == "table" and x.isvector then
        self.speed = vector
    else
        self.speed = Vector(x, y)
    end
end

function Entity:velocity()
    return self.speed
end

function Entity:depth()
    return 1
end

function Entity:setPosition(x, y)
    self.x = x
    self.y = y
end

function Entity:gravity()
    return 360
end

function Entity:remove()
    return self.flags.remove
end

function Entity:position()
    return self.x, self.y
end

function Entity:size()
    return self.width, self.height
end

function Entity:bounds()
    return self.x, self.y, self.width, self.height
end

function Entity:center(which)
    local x = self.x + (self.width / 2)
    local y = self.y + (self.height / 2)

    if which == "x" then
        return x
    end

    if which == "y" then
        return y
    end

    return Vector(x, y)
end

function Entity:static()
    return self.flags.static
end

function Entity:passive()
    return self.flags.passive
end

function Entity:frozen()
    return self.flags.frozen
end

return Entity
