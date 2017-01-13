water = class("water")

function water:init(x, y, properties)
    self.x = x
    self.y = y
    
    self.width = properties.width
    self.height = 16

    self.timer = 0
    self.quadi = 1
end

function water:update(dt)
    self.timer = self.timer + 6 * dt
    self.quadi = math.floor(self.timer % #waterQuads) + 1
end

function water:draw()
    for x = 1, self.width / 16 do
        love.graphics.draw(waterImage, waterQuads[self.quadi], self.x + (x - 1) * 16, self.y)
    end
end