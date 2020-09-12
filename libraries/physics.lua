local physics = {}

local bump = require("libraries.bump")

physics.CONST_TILE_SIZE = 32
physics.CONST_TILE_SCREEN_HEIGHT = 720 / physics.CONST_TILE_SIZE
physics.CONST_MAX_GRAVITY = physics.CONST_TILE_SIZE * physics.CONST_TILE_SCREEN_HEIGHT

function physics:init(entities)
    self.world = bump.newWorld(32)
    self.entities = entities

    for i = 1, #entities do
        self:addEntity(entities[i])
    end

    return self
end

function physics:update(dt)
    for _, entity in pairs(self.entities) do
        if not entity:static() then
            local speed = entity.speed

            if entity:gravity() ~= 0 then
                speed.y = math.min(speed.y + entity:gravity() * dt, physics.CONST_MAX_GRAVITY)
            end

            local x, y = entity.x, entity.y
            local actualX, actualY, collisions, _

            if not entity:frozen() then
                actualX, actualY, collisions, _ = self.world:move(entity, x + speed.x * dt, y + speed.y * dt, entity:filter())
            else
                actualX, actualY, collisions, _ = self.world:move(entity, x, y, entity:filter())
            end

            if #collisions > 0 then
                for i = 1, #collisions do
                    if collisions[i].normal.y ~= 0 then
                        self:resolveVertical(entity, collisions[i])
                    elseif collisions[i].normal.x ~= 0 then
                        self:resolveHorizontal(entity, collisions[i])
                    end
                end
            end

            entity:setPosition(actualX, actualY)
        end

        entity:update(dt)
    end
end

function physics:resolveVertical(entity, against)
    local speed  = entity.speed

    if speed.y > 0 then
        if entity.floorCollide then
            if not entity:floorCollide(against.other, tostring(against.other), against.type) then
                speed.y = 0
            end
        else
            speed.y = 0
        end
    else
        if entity.ceilCollide then
            if not entity:ceilCollide(against.other, tostring(against.other), against.type) then
                speed.y = 0
            end
        else
            speed.y = 0
        end
    end
end

function physics:resolveHorizontal(entity, against)
    local speed  = entity.speed

    if speed.x > 0 then
        if entity.rightCollide then
            if not entity:rightCollide(against.other, tostring(against.other), against.type) then
                speed.x = 0
            end
        else
            speed.x = 0
        end
    else
        if entity.leftCollide then
            if not entity:leftCollide(against.other, tostring(against.other), against.type) then
                speed.x = 0
            end
        else
            speed.x = 0
        end
    end
end

function physics:getEntity(name, all)
    local ret = {}

    for i = 1, #self.entities do
        if tostring(self.entities[i]) == name then
            if not all then
                return self.entities[i]
            end

            table.insert(ret, self.entities[i])
        end
    end

    return ret
end

function physics:getEntitiesByProperty(property)
    local ret = {}

    for i = 1, #self.entities do
        if self.entities[i][property] then
            table.insert(ret, self.entities[i])
        end
    end

    return ret
end

function physics:checkCollision(entity, other)
    local v1x, v1y, v1width, v1height = entity:bounds()
    local v2x, v2y, v2width, v2height = other:bounds()

    local v1farx, v1fary, v2farx, v2fary = v1x + v1width, v1y + v1height, v2x + v2width, v2y + v2height

	return v1farx > v2x and v1x < v2farx and v1fary > v2y and v1y < v2fary
end

function physics:getEntities()
    return self.entities
end

function physics:addEntity(entity)
    self.world:add(entity, entity:bounds())
end

function physics:removeEntity(entity)
    self.world:remove(entity)
end

return physics
