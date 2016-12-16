turtle = class("turtle")

function turtle:init(x, y)
    self.x = x
    self.y = y

    self.width = 12
    self.height = 14

    self.timer = 0
    self.quadi = 1

    self.state = "idle"

    self.screen = "top"

    self.active = true

    self.gravity = 360
    
    self.speedx = 0
    self.speedy = 0

    self.category = 2

    self.mask =
    {
        true, false, true, false
    }

    self.rightKey = false
    self.leftKey = false
    self.useKey = false

    self.walkSpeed = 2
    self.maxWalkSpeed = 80

    self.scale = scale
    self.offsetX = 0

    self.maxHealth = 3
    self.health = self.maxHealth
    self.render = true

    self.frozen = false
end

function turtle:update(dt)
    if self.rightKey then
        self.speedx = self.maxWalkSpeed
    elseif self.leftKey then
        self.speedx = -self.maxWalkSpeed
    elseif not self.rightKey and not self.leftKey then
        self.speedx = 0
    end

    if self.speedx ~= 0 then
        if self.rightKey then
            if self.speedx < 0 then
                self.speedx = math.min(self.speedx + 2, 0)
            end

            self.scale = scale
            self.offsetX = 0
        elseif self.leftKey then
            if self.speedx > 0 then
                self.speedx = math.max(self.speedx - 2, 0)
            end

            self.scale = -scale
            self.offsetX = self.width
        end

        if not self.jumping then
            self:setState("walk")
            self.timer = self.timer + math.abs(self.speedx) * 0.1 * dt
        end
    elseif self.speedx == 0 and self.speedy == 0 then
        self:setState("idle")
        self.timer = self.timer + 6 * dt
    end
    
    if self.speedy ~= 0 then
        self:setState("jump")
        if self.quadi < 3 then
            self.timer = self.timer + 4 * dt
        end
    end

    self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1
end

function turtle:draw()
    if not self.render then
        return
    end

    love.graphics.draw(turtleImage, turtleQuads[self.state][self.quadi], self.x + self.offsetX, self.y - 6, 0, self.scale, 1)
end

function turtle:downCollide(name, data)
    self.jumping = false
end

function turtle:setScale(scale)
    if scale == 1 then
        self.offsetX = 0
    else
        self.offsetX = self.width
    end
    self.scale = scale
end

function turtle:use(move)
    self.useKey = move
end

function turtle:freeze(freeze)
    self.frozen = freeze

    self.speedx = 0
    self.speedy = 0
end

function turtle:moveRight(move)
    self.rightKey = move
end

function turtle:moveLeft(move)
    self.leftKey = move
end

function turtle:jump()
    if not self.jumping then
        
        self.speedy = -jumpForce - (math.abs(self.speedx) / self.maxWalkSpeed) * jumpForceAdd * 0.5
        jumpSound:play()

        self.jumping = true
    end
end

function turtle:stopJump()
    if self.speedy < 0 then
        self.speedy = self.speedy * 0.05
    end
end

function turtle:setState(state)
    if self.state ~= state then
        self.quadi = 1
        self.timer = 0
        self.state = state
    end
end

function turtle:hurt()

end

function turtle:setRender(render)
    self.render = render
end

function turtle:getHealth()
    return self.health
end

function turtle:getMaxHealth()
    return self.maxHealth
end