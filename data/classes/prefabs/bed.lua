local Interactive = require("data.classes.mixin.interactive")
local Bed = Interactive:extend()

Bed.texture = love.graphics.newImage("graphics/prefabs/bed.png")
Bed.quads = {}

for i = 1, 5 do
    Bed.quads[i] = love.graphics.newQuad(0, (i - 1) * 34, 64, 34, Bed.texture)
end

function Bed:new(x, y)
    Bed.super.new(self, x, y, 64, 34)

    self.timer = 0
    self.quadi = 1
end

function Bed:update(dt)
    Bed.super.update(self, dt)

    if not self.flags.inUse then
        self.quadi = 1
        return
    end

    self.timer = self.timer + 1.5 * dt
    self.quadi = 1 + math.floor(self.timer % 4) + 1
end

function Bed:use(entity)
    self:toggle()

    if self:inUse() then
        entity.flags.noDraw = true
        entity.flags.frozen = true
    else
        entity.flags.noDraw = false
        entity.flags.frozen = false
    end

    entity:useEntity(false)
end

function Bed:draw()
    Bed.super.draw(self)

    love.graphics.draw(Bed.texture, Bed.quads[self.quadi], self.x, self.y)

    if self:inUse() and math.floor(self.timer) % 2 == 0 then
        love.graphics.setFont(fonts.SMALL)
        love.graphics.print("z", self.x + math.floor(self.width * 0.25), self.y - 22)
    end
end

function Bed:static()
    return true
end

function Bed:passive()
    return true
end

function Bed:__tostring()
    return "bed"
end

return Bed