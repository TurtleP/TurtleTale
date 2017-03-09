trigger = class("trigger")

function trigger:init(x, y, property)
    self.x = x
    self.y = y

    self.width = 8
    self.height = 240

    if property.map then
        self.map = property.map:split(";")
    end

    self.category = 4

    self.triggered = false
end

function trigger:update(dt)
    local ret = checkrectangle(self.x - 4, self.y, self.width, self.height, {"player"}, self)

    if not self.map then
        return
    end

    if self.triggered then
        local player = objects["player"][1]
        local map = self.map[1]
        
        SPAWN_X, SPAWN_Y = tonumber(self.map[2]), tonumber(self.map[3])

        player:moveRight(false)
        player:moveLeft(false)
        player:punch(false)

        player.speedx = 0

        player:setState("idle")
                
        self.triggered = false

        gameInit(map)         
    end

    if #ret == 0 then
        return
    else
        local player = ret[1][2]
         
        player.speedx = 48 * player.scale
        local dir = "right"
        if player.speedx < 0 then
            dir = "left"
        end

        if not self.triggered then
            if dir == "right" then
                player:moveRight(true)
            else
                player:moveLeft(true)
            end

            self.triggered = true
        end
    end
end