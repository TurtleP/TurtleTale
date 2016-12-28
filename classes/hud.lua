hud = class("hud")

function hud:init()
    self.x = 4
    self.y = 4
end

function hud:draw()
    if eventSystem:isRunning() then
        return
    end
    
    for x = 1, objects["player"][1]:getMaxHealth() do
        local offset, quadi = 0, 1
        if x % 2 == 0 then
            offset = 4
        end
        if x > objects["player"][1]:getHealth() then
            quadi = 2
        end

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(healthImage, healthQuads[quadi], self.x + (x - 1) * 8, self.y + offset)
    end
end