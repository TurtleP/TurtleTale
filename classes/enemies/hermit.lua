hermit = class("hermit")

function hermit:init(x, y)
    self.x = x
    self.y = y

    self.width = 12
    self.height = 12

    self.mask =
    {
        true, true, true
    }

    self.state = "idle"

    self.quadi = 1
    self.timer = 0

    self.active = true

    self.gravity = 480

    self.speedx = 0
    self.speedy = 0

    self.idleTime = math.random(1, 2)
    self.walkTime = math.random(2, 4)

    self.scale = -1
    self.offsetX = 14

    self.health = 4
    self.shakeTimer = 0
end

function hermit:shake(val)
    if self.shakeTimer == 0 then
        self.shakeTimer = 0.5
        table.insert(hitNumbers, hitnumber:new(math.random(self.x, self.x + self.width), self.y, val))
        self:addLife(val)
    end
end

function hermit:update(dt)
    if self.shakeTimer > 0 then
        self.shakeTimer = math.max(self.shakeTimer - dt, 0)
        self.speedx = 0
        return
    end

    if self.walkTime > 0 then
        self.walkTime = self.walkTime - dt
        self.speedx = 32 * -self.scale
    else
        self.speedx = 0
        if self.idleTime > 0 then
            self.idleTime = self.idleTime - dt
        else
            self:setDirection(-self.scale)
            self.idleTime = math.random(1, 2)
            self.walkTime = math.random(2, 4)
        end
    end

    if self.speedx ~= 0 then
        self.state = "walk"
    else
        if not self.attacking then
            self.state = "idle"
        end
    end

    self.timer = self.timer + 6 * dt
    self.quadi = math.floor(self.timer % #hermitQuads[self.state]) + 1
end

function hermit:draw()
    local offset = 0
    if self.shakeTimer > 0 then
        offset = math.sin(love.timer.getTime() * 8)
    end
    love.graphics.draw(hermitImage, hermitQuads[self.state][self.quadi], self.x + self.offsetX + offset, self.y - 4, 0, self.scale, 1)
end

function hermit:addLife(health)
    self.health = math.max(self.health - health, 0)

    if self.health == 0 then
        self.remove = true
    end
end

function hermit:upCollide(name, data)
    if name == "player" then
        return false
    end
end

function hermit:rightCollide(name, data)
    if name == "player" then
        return false
    end
end

function hermit:downCollide(name, data)
    if name == "player" then
        return false
    end
end

function hermit:leftCollide(name, data)
    if name == "player" then
        return false
    end
end

function hermit:setDirection(dir)
    self.scale = dir

    if dir == 1 then
        self.offsetX = -2
    else
        self.offsetX = 14
    end
end