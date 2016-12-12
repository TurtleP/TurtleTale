tile = class("tile")

function tile:init(x, y, r, background)
    self.x = x
    self.y = y
    
    self.width = 16
    self.height = 16

    self.r = r

    self.category = 1

    self.active = true
    self.static = true
    
    self.screen = "top"

    for k, v in pairs(tilesMask[r]) do
        self[k] = v
    end

    if not background then
        self.draw = function(self)
            love.graphics.draw(gameTiles, tileQuads[self.r], self.x, self.y)
        end
    end
end