door = class("door")

function door:init(x, y, properties, screen)
    self.x = x
    self.y = y

    self.width = 16
    self.height = 16

    self.map = properties.link

	self.spawn = {properties.x, properties.y}
	
    self.render = false

    self.category = 4

    self.active = true
    self.static = true

    self.timer = 0
    self.quadi = 1

    self.screen = screen
    self.doTransition = false
end

function door:update(dt)
    local ret = checkrectangle(self.x + 4, self.y, self.width - 8, self.height, {"player"}, self)

    self.render = #ret > 0

    if not self.render then
        return
    else
        if ret[1][2].useKey then
            self.doTransition = true
        end

        if self.doTransition then
            ret[1][2]:freeze()
            gameFadeOut = true

            if gameFade == 1 then
				SPAWN_X, SPAWN_Y = self.spawn[1], self.spawn[2]
                gameInit(self.map)
            end
        end
    end

    self.timer = self.timer + 12 * dt
    self.quadi = math.floor(self.timer % 8) + 1
end

function door:draw()
    if not self.render then
        return
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.draw(selectionVerImage, selectionVerQuads[self.quadi], (self.x + (self.width / 2)) - 6, (self.y - 19) + math.sin(love.timer.getTime() * 4))

    love.graphics.setColor(255, 0, 0)
    love.graphics.draw(selectionVerImage, selectionVerQuads[self.quadi], (self.x + (self.width / 2)) - 5, (self.y - 18) + math.sin(love.timer.getTime() * 4))

    love.graphics.setColor(255, 255, 255)
end