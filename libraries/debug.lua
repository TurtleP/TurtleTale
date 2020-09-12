local FONT = love.graphics.newFont(16)

local DebugDraw = {}

local function wireframe(zoom, scale, x, y, width, height)
    love.graphics.rectangle("line", x * (scale / zoom), y * (scale / zoom),
                                    width * (scale / zoom), height * (scale / zoom))
end

function DebugDraw:init()
    self.zoom = 1

    self.active = false
    self.fpsOnly = false

    return self
end

function DebugDraw:draw(physics)
    if not self.active then
        return
    end

    love.graphics.setColor(1, 1, 1, 1)

    if not self.fpsOnly then
        for _, entity in ipairs(physics:getEntities()) do
            local x, y, w, h = entity:bounds()
            wireframe(self.zoom, 1, x, y, w, h)
        end
    end

    love.graphics.setFont(FONT)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
end

function DebugDraw:zoom(amount)
    if amount > 0 then
        self.zoom = math.min(self.zoom + amount, 1 * 4)
    else
        self.zoom = math.max(self.zoom + amount, 1)
    end
end

function DebugDraw:toggle(mode)
    self.fpsOnly = (mode == "fps")
    self.active = not self.active
end

return DebugDraw:init()
