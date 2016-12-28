local tiled = {}

function tiled:init()
    self.mapWidth = {["top"] = 0, ["bottom"] = 0}
    self.mapHeight = 15

    self.tiles = {}
    self.objects = {}

    self.music = {["top"] = "", ["bottom"] = ""}
    self.background = nil

    self.backgroundScrolls = {0, 0}
end

function tiled:loadMap(path)
    self:init()

    self.map = require(path)

    self:loadData("top")
    self:loadData("bottom")
end

function tiled:cacheMaps()
    self:init()

    self.maps = {}
    
    local files = 
    {
        "home",
        "indoors",
        "beach",
        "cliff"
    }

    for k = 1, #files do
        self.maps[files[k]] = require("maps/" .. files[k])
    end
end

function tiled:setMap(map)
    self:init()

    self.map = self.maps[map]

    self.currentMap = map
    
    self:loadData("top")

    if state == "game" then --gg
        gameCreateTables()
    end
end

function tiled:loadData(screen)
    local mapData, entityData = self.map.layers, {}

    for k, v in ipairs(mapData) do
        if v.type == "tilelayer" then
            if v.name == screen .. "Tiles" then
                mapData = self.map.layers[k].data

                self.mapWidth[screen] = self.map.layers[k].properties.width
                self.mapHeight = self.map.layers[k].properties.height

                if screen == "top" then
                    if love.filesystem.isFile("maps/" .. self.currentMap .. ".png") then
                        self.background = love.graphics.newImage("maps/" .. self.currentMap .. ".png")
                    end
                end

                self.music[screen] = self.map.layers[k].properties.music
            end
        elseif v.type == "objectgroup" then
            if v.name == screen .. "Objects" then
                entityData = self.map.layers[k].objects
            end
        end
    end

    
    for y = 1, self.map.height do
        for x = 1, self.map.width do
            local r = mapData[(y - 1) * self.map.width + x]

            if tonumber(r) then
                if r  > 0 then
                    self.tiles[x .. "-" .. y] = tile:new((x - 1) * 16, (y - 1) * 16, r, self.background)
                end
            end
        end
    end

    for k, v in ipairs(entityData) do
        if not self.objects[v.name] then
            self.objects[v.name] = {}
        end

        if _G[v.name] then
            table.insert(self.objects[v.name], _G[v.name]:new(v.x, v.y, v.properties, screen))
        end
    end
end

function tiled:getNextMap(dir)
    if dir == "right" then
        return self.map.properties.right
    end
    return self.map.properties.left
end

function tiled:renderBackground()
    if self.background then
        love.graphics.draw(self.background, 0, 0)
    else
        for k, v in pairs(self.tiles) do
            if self.tiles[k].draw then
                self.tiles[k]:draw()
            end
        end
    end
end

function tiled:getBackgroundColor()
    return backgroundColors[backgroundColori[player.screen]]
end

function tiled:changeSong(screen)
    local otherScreen = "top"
    if screen == "top" then
        otherScreen = "bottom"
    end
    _G[self.music[otherScreen] .. "Song"]:stop()
    playSound(_G[self.music[screen] .. "Song"])
end

function tiled:getWidth(screen)
    return self.mapWidth[screen]
end

function tiled:getTiles()
    return self.tiles
end

function tiled:getObjects(name)
    if type(name) == "table" then
        local ret = {}

        for i = 1, #name do
            if self.objects[name[i]] then
                table.insert(ret, self.objects[name[i]])
            end
        end

        return ret
    end
    return self.objects[name]
end

function tiled:getMapName()
    return self.currentMap
end

return tiled