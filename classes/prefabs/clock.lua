clock = class("clock")

function clock:init(x, y)
    self.x = x
    self.y = y

    self.width = 15
    self.height = 32

    self.timer = 0
    self.quadi = 1

    self.animation = {1, 2, 3, 2}
end

function clock:update(dt)
    self.timer = self.timer + 2 * dt
    self.quadi = self.animation[math.floor(self.timer % #self.animation) + 1]
end

function clock:draw()
    love.graphics.draw(clockImage, clockQuads[self.quadi], self.x, self.y)
end