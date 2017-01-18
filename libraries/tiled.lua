local tiled = {}

function tiled:init()
    self.mapWidth = {["top"] = 0, ["bottom"] = 0}
    self.mapHeight = 15

    self.objects = {}

    self.music = {["top"] = "", ["bottom"] = ""}
    self.background = nil

    self.tiles = nil
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
        "beach2",
        "cliff",
        "throne",
        "pathway"
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

    if screen == "top" then
        if love.filesystem.isFile("maps/" .. self.currentMap .. ".png") then
            self.tiles = love.graphics.newImage("maps/" .. self.currentMap .. ".png")
        end
        
        if backgroundImages[self.currentMap] then
            if backgroundImages[self.currentMap][self.map.properties.background] then
                self.background = backgroundImages[self.currentMap][self.map.properties.background]
            end
        end
    end

    for k, v in ipairs(mapData) do
        if v.type == "tilelayer" then
            if v.name == screen .. "Tiles" then
                mapData = self.map.layers[k].data

                self.mapWidth[screen] = self.map.width
                self.mapHeight = self.map.layers[k].properties.height

                self.music[screen] = self.map.layers[k].properties.music
            end
        elseif v.type == "objectgroup" then
            if v.name == screen .. "Objects" then
                entityData = self.map.layers[k].objects
            end
        end
    end

    for k, v in ipairs(entityData) do
        if not self.objects[v.name] then
            self.objects[v.name] = {}
        end

        if _G[v.name] then
            if v.name == "tile" then
                table.insert(self.objects["tile"], tile:new(v.x, v.y, v.width, v.height))
            else
                table.insert(self.objects[v.name], _G[v.name]:new(v.x, v.y, v.properties, screen))
            end
        end
    end
end

function tiled:getNextMap(dir)
    if not self.objects["trigger"] then
        return false
    end

    for i = 1, #self.objects["trigger"] do
        local v = self.objects["trigger"][i]

        if dir == "left" and v.x == 0 then
            return true
        elseif dir == "right" and v.x == self:getWidth("top") * 16 then
            return true
        end 
    end

    return false
end

function tiled:renderBackground()
    if self.background then
        if state ~= "title" then
            love.graphics.draw(self.background, 0, 0)
        end
    end

    if self.tiles then
        love.graphics.draw(self.tiles, 0, 0)
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
    return self.objects["tile"]
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