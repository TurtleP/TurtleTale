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

    self.punching = false

    self.abilities = 
    {
        ["punch"] = true
    }

    self.walkSpeed = 2
    self.maxWalkSpeed = 80

    self.scale = scale
    self.offsetX = 0

    self.health = saveManager:getSaveData()[2] or 3
    self.maxHealth = saveManager:getSaveData()[3] or 3

    self.render = true

    self.frozen = false

    self.invincible = false

    self.disableTimer = 0
    self.invincibleTimer = 0

    self.changeMap = false
end

function turtle:update(dt)
    if self.dead then
        self:setState("dead")
        if self.quadi < #turtleQuads[self.state] then
            self.timer = self.timer + 6 * dt
            self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1
        end

        gameOver = true

        return
    end

    if self.y > love.graphics.getHeight() then
        self:die("pit")
    end

    if self.state ~= "punch" then
        if self.rightKey then
            self.speedx = self.maxWalkSpeed
        elseif self.leftKey then
            self.speedx = -self.maxWalkSpeed
        elseif not self.rightKey and not self.leftKey then
            self.speedx = 0
        end
    else
        if self.speedy == 0 then
            self.speedx = 0
        end
    end

    if not self.abilities[self.state] then
        if self.speedx ~= 0 then
            local modifier = 2

            if self.rightKey then
                if self.speedx < 0 then
                    self.speedx = math.min(self.speedx + modifier, 0)
                end

                self.scale = scale
                self.offsetX = 0
            elseif self.leftKey then
                if self.speedx > 0 then
                    self.speedx = math.max(self.speedx - modifier, 0)
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
    else
        if self.quadi < #turtleQuads[self.state] then
            self.timer = self.timer + 6 * dt
        else
            if self.state == "punch" then
                local add = self.width + 12
                if self.scale == -1 then
                    add = -12
                end

                local check = checkrectangle(self.x + add, self.y + 8, 4, 4, {"hermit"})
                if #check > 0 then
                    local v = check[1][2]
                    v:shake(math.random(1, 2))
                end
            end
            self:setState("idle") --blank cause no state?
        end
    end

    if self.invincible then
        self.invincibleTimer = self.invincibleTimer + 8 / 0.8 * dt

        if math.floor(self.invincibleTimer) % 2 == 0 then
            self.render = false
        else
            self.render = true
        end

        if self.invincibleTimer > 16 then
            self.invincibleTimer = 0
            self.invincible = false
            self.render = true
        end
    end

    self.quadi = math.floor(self.timer % #turtleQuads[self.state]) + 1
end

function turtle:draw()
    if not self.render then
        return
    end

    love.graphics.draw(turtleImage, turtleQuads[self.state][self.quadi], self.x + self.offsetX, self.y - 6, 0, self.scale, scale)
end

function turtle:rightCollide(name, data)
    if name == "hermit" then
        self:addLife(-1)
        return false
    end
end

function turtle:leftCollide(name, data)
    if name == "hermit" then
        self:addLife(-1)
        return false
    end
end

function turtle:upCollide(name, data)
    if name == "hermit" then
        self:addLife(-1)
        return false
    end
end

function turtle:downCollide(name, data)
    self.jumping = false

    if name == "hermit" then
        self:addLife(-1)
        return false
    end
end

function turtle:addLife(health)
    if health < 0 then
        if not self.invincible then
            self.invincible = true
        else
            return
        end
    end
    
    self.health = math.max(self.health + health, 0)

    if self.health == 0 then
        self:die()
    end
end

function turtle:die(pit) -- rip :(

    if pit then
        shakeValue = 4
        pitDeathSound:play()
        self:addLife(-1)
    end

    if self.health > 1 then
        self.x = SPAWN_X
        self.y = SPAWN_Y

        return
    end

    if not self.dead then
        self.speedx = 0
        self.speedy = 0

        self.dead = true
    end
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
    self.timer = 0
end

function turtle:moveRight(move)
    self.rightKey = move
end

function turtle:moveLeft(move)
    self.leftKey = move
end

function turtle:jump()
    if not self.jumping and not self.dead then
        
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

function turtle:punch()
    self:setState("punch")
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