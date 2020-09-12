local Entity = require("data.classes.entity")
local Player = Entity:extend()

Player.CONST_MOVE_SPEED = 200

local turtleQuads = {}
local turtleAnimations =
{
    {"idle", 4}, {"walk", 4}, {"jump", 3},
    {"dead", 6}, {"duck", 6}, {"unduck", 5},
    {"carry", 3}, {"punch", 4}, {"climb", 6}
}

Player.texture = love.graphics.newImage("graphics/entities/player.png")
Player.quads = {}

for y = 1, #turtleAnimations do
    Player.quads[turtleAnimations[y][1]] = {}
    for x = 1, turtleAnimations[y][2] do
        table.insert(Player.quads[turtleAnimations[y][1]], love.graphics.newQuad((x - 1) * 24, (y - 1) * 40, 24, 40, Player.texture))
    end
end

function Player:new(x, y)
    Player.super.new(self, x, y, 24, 28)

    self.keys = {left = false, right = false, up = false}

    self.state = "idle"
    self.timer = 0
    self.quadi = 1

    self.animationRules =
    {
        idle = {rate = 6, stop = false},
        walk = {rate = 6, stop = false},
        jump = {rate = 4, stop = true, exception = "walk"},
        dead = {rate = 8, stop = true},
        duck = {rate = 8, stop = true},
        unduck = {rate = 8, stop = true, func = function()
            self:setState("idle")
            self.y = self.y - 6
            self.height = 14
            self.ducking = false
        end},
        climb = {rate = 10, stop = false, condition = function()
            return self.speed.y ~= 0
        end},
        punch = {rate = 14, stop = false},
        carry = {rate = 6, stop = false}
    }

    self.scale = 1
end

function Player:speak(text)
    dialect.speak("Turtle", text, {profile = "turtle"})
end

function Player:gravity()
    return 720
end

function Player:filter()
    return function(this, entity)
        if entity:passive() then
            if entity.interactive and entity:canBeUsedBy(self) then
                if self.keys.up then
                    entity:use(self)
                end
            end
            return false
        end
        return "slide"
    end
end

function Player:animate(dt)
    self.timer = self.timer + self.animationRules[self.state].rate * dt
    if self.animationRules[self.state].stop and self.quadi == #Player.quads[self.state] then
        if self.animationRules[self.state].func then
            self.animationRules[self.state].func()
        end
        return
    elseif self.animationRules[self.state].condition then
        if not self.animationRules[self.state].condition() then
            return
        end
    end
    self.quadi = math.floor(self.timer % #Player.quads[self.state]) + 1
end

function Player:update(dt)
    if self.keys.right or self.keys.left then
        self:setState("walk")
        if self.keys.right then
            self.speed.x = Player.CONST_MOVE_SPEED
            self.scale = 1
        elseif self.keys.left then
            self.speed.x = -Player.CONST_MOVE_SPEED
            self.scale = -1
        end
    else
        self:setState("idle")
        self.speed.x = 0
    end

    if self.speed.y ~= 0 then
        self:setState("jump")
    end

    for _, entity in pairs(tiled.interactive) do
        entity:canBeUsedBy(self)
    end

    self:animate(dt)
end

function Player:draw()
    love.graphics.draw(Player.texture, Player.quads[self.state][self.quadi], self.x + self:getXOffset(), self.y - self:getYOffset(), 0, self.scale, 1)
end

function Player:getXOffset()
    if self.scale < 1 then
        return self.width
    end
    return 0
end

function Player:getYOffset()
    local offset = 12
    if self.ducking then
        offset = 24
    end
    return offset
end

function Player:move(dir, enable)
    self.keys[dir] = enable
end

function Player:jump()
    if self.speed.y == 0 and not self.jumping then
        self.speed.y = -360
        self.jumping = true
    end
end

function Player:useEntity(enable)
    self.keys.up = enable
end

function Player:floorCollide(data, name)
    if name == "tile" then
        self.jumping = false
    end
end

function Player:setState(state)
    if self.state ~= state then
        self.timer = 0
        self.quadi = 1
        self.state = state
    end
end

function Player:__tostring()
    return "player"
end

return Player