local SGM = {}

function SGM:init()
    local path = "sdmc:/LovePotion/TurtleTale"

    if _EMULATEHOMEBREW then
        path = love.filesystem.getSaveDirectory() 
    else
        love.filesystem.createDirectory(path)
    end

    self.path = path

    local file = io.open(path .. "/save.lua", "rb")
    if not file then
        file = io.open(path .. "/save.lua", "w")

        if file then
            file:write("return\n{\n\tnil,\n\tnil,\n\tnil\n}")

            file:flush()
                
            file:close()
        end
    end

    self.currentSave = nil

    local files = nil
    if io.open(path .. "/save.lua", "r") then
        files = dofile(path .. "/save.lua")
    end

    self.files = files 
end

function SGM:select(i)
    self.currentSave = i

    SPAWN_X, SPAWN_Y = self.files[i][6], self.files[i][7]
    currentScript = self.files[i][8]
end

function SGM:getMap()
    return self.files[self:getCurrentSave()][5]:gsub('"', "")
end

function SGM:generateSaveData(data)
    if not data then
        return 
        {
            '"' .. os.date("%m.%d.%Y") .. '"', 
            objects["player"][1]:getHealth(), 
            objects["player"][1]:getMaxHealth(), 
            math.floor(self:getTime()),
            '"' .. tiled:getMapName() .. '"', 
            math.floor(objects["player"][1].x), 
            math.floor(objects["player"][1].y),
            currentScript
        }
    else
        data[1], data[5] = '"' .. data[1] .. '"', '"' .. data[5] .. '"'

        return data
    end
end

function SGM:save(t, toSave)
    if self.files then
        self.files[t] = toSave

        self.currentSave = t

        local path = self.path
        if _EMULATEHOMEBREW then
            path = ""
        end
        love.filesystem.remove(path .. "/save.lua")

        local file = io.open(self.path .. "/save.lua", "w")
        
        if file then
            file:write("return\n{\n\t")

            for i = 1, #self.files do
                if i ~= self.currentSave then
                    self.files[i] = self:generateSaveData(self.files[i])
                end

                if self.files[i] ~= nil then
                    file:write("{")
                    
                    for j = 1, #self.files[i] do
                        local append = ", "
                        if j == #self.files[i] then
                            append = ""
                        end

                        file:write(self.files[i][j] .. append)
                    end

                    file:write("},\n\t")
                else
                    file:write("nil,\n\t")
                end
            end

            file:write("\n}")

            file:flush()

            file:close()
        end
    end
end

function SGM:tick(dt)
    local i = self:getCurrentSave()

    self.files[i][4] = self.files[i][4] + dt
end

function SGM:getTime()
    return self.files[self:getCurrentSave()][4]
end

function SGM:deleteData(i)
    --just gonna .. call the things n stuff
    self:save(i, nil)
end

function SGM:getSaveData(i)
    local j = i
    if not j then
        j = self.currentSave or 1
    end

    return self.files[j]
end

function SGM:getCurrentSave()
    if not self.currentSave then
        return 1
    end

    return self.currentSave
end

return SGM