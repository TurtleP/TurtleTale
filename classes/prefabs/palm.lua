palm = class("palm")

function palm:init(x, y)
    self.x = x
    self.y = y

    self.width = 32
    self.height = 32

    self.timer = 0
    self.quadi = 1

    self.windTimer = math.random(1, 5)
    self.windTimes = math.random(1, 3)

    self.cycles = 0
end

function palm:update(dt)
    if self.windTimer > 0 then
        self.windTimer = self.windTimer - dt
    else
        if self.cycles < self.windTimes then
            if self.quadi < #palmTreeQuads then
                self.timer = self.timer + 6 * dt
                self.quadi = math.floor(self.timer % #palmTreeQuads) + 1
            else
                self.cycles = self.cycles + 1
                self.quadi = 1
                self.timer = 0
            end
        else
            self.timer = 0
            self.quadi = 1
            self.windTimer = math.random(1, 5)
            self.windTimes = math.random(1, 3)
            self.cycles = 0
        end
    end
end

function palm:draw()
    love.graphics.draw(palmTreeImage, palmTreeQuads[self.quadi], self.x, self.y)
end