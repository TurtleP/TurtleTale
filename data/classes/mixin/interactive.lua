local Entity = require("data.classes.entity")
local Interactive = Entity:extend()

Interactive.texture = love.graphics.newImage("graphics/select.png")
Interactive.quads = {}

for y = 1, 8 do
    Interactive.quads[y] = love.graphics.newQuad(0, (y - 1) * 10, 20, 10, Interactive.texture)
end

function Interactive:new(x, y, width, height)
    Interactive.super.new(self, x, y, width, height)

    self.time = 0
    self.quad = 1

    self.flags.display = false
    self.flags.inUse = false
    self.interactive = true
end

function Interactive:update(dt)
    if not self.flags.display then
        return
    end

    self.time = self.time + 8 * dt
    self.quad = math.floor(self.time % #Interactive.quads) + 1
end

function Interactive:toggle()
    self.flags.inUse = not self.flags.inUse
end

function Interactive:fire()
    if not self.flags.inUse then
        self.flags.inUse = true
    end
end

function Interactive:inUse()
    return self.flags.inUse
end

function Interactive:draw()
    if not self.flags.display or (self.flags.display and self:inUse()) then
        return
    end

    love.graphics.draw(Interactive.texture, Interactive.quads[self.quad], self.x + (self.width - 20) / 2, (self.y - 15) + math.sin(love.timer.getTime() * 4) * 2)
end

function Interactive:use(entity)
    assert("Interactive.use not implemented!")
end

function Interactive:canBeUsedBy(entity)
    self.flags.display = physics:checkCollision(self, entity)
    return self.flags.display
end

return Interactive