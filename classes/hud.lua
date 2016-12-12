hud = class("hud")

function hud:init()
    self.x = 4
    self.y = 4
end

function hud:draw()
    if eventSystem:isRunning() then
        return
    end
    
    for x = 1, objects[2][1]:getMaxHealth() do
        local offset = 0
        if x % 2 == 0 then
            offset = 4
        end

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(healthImage, healthQuads[1], self.x + (x - 1) * 8, self.y + offset)
    end
end