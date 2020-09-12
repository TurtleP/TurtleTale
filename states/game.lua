dialect = require("libraries.dialect")
dialect.setFont(fonts.DIALOG)

tiled = require("libraries.tiled")
local camera = require("libraries.camera")
local debug = require("libraries.debug")

local game = {}

function game:load()
    tiled.loadMap("house")

    self.player = tiled.getEntity("player")

    self.camera = camera(self.player:position())
    self.camera:zoom(1.5)

    self.player:speak("Oh? You're approaching me? Well, in that case.." .. dialect.pauseChar .. "Turtle Tale 2: Electric Boogaloo!")
end

local function updateCamera(player, camera)
    local s = 1 / camera.scale -- zoom or scale of the camera
    -- local vw, vh = 1280, 720 -- dimensions of the viewport (in screen coords)s
    local wvw, wvh = 1280 / (2 * camera.scale), 720 / (2 * camera.scale)
    local dx, dy = player.x - camera.x, player.y - camera.y

    camera.x = math.clamp(camera.x + dx / 2, 0 + wvw, tiled.width  - wvw)
    camera.y = math.clamp(camera.y + dy / 2, 0 + wvh, tiled.height - wvh)
end

function game:update(dt)
    tiled.update(dt)

    updateCamera(self.player, self.camera)

    dialect.update(dt)
end

function game:draw()
    self.camera:attach()

    tiled.draw()

    self.camera:detach()

    dialect.draw()
end

function game:gamepadaxis(joy, axis, value)
    if axis == "leftx" then
        if value > 0.5 then
            self.player:move("left", false)
            self.player:move("right", true)
        elseif value < -0.5 then
            self.player:move("right", false)
            self.player:move("left",  true)
        else
            self.player:move("left", false)
            self.player:move("right", false)
        end
    elseif axis == "lefty" then
        if value < -0.5 then
            self.player:useEntity(true)
        end
    end
end

function game:gamepadpressed(joy, button)
    if button == "a" then
        self.player:jump()
    end

    if button == "back" then
        debug:toggle()
    end
end

function game:gamepadreleased(joy, button)
    if button == "a" then
        dialect.gamepadreleased(button)
    end
end

function game:unload()

end

return game