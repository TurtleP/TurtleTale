local SGM = {}

function SGM:init()
    local path = "sdmc:/LovePotion/TurtleTale"

    if _EMULATEHOMEBREW then
        path = love.filesystem.getSaveDirectory() 
        love.filesystem.write("dummy.txt", "")
    else
        love.filesystem.createDirectory(path)
    end

    if love.system.getOS() == "Windows" then
        path = path:gsub("/", "\\")
    end

    self.path = path

    self:generateFiles()

    self.currentSave = nil

    if self:open(path .. "/save.lua", "r") then
        if not self:catchError(dofile, path .. "/save.lua") then
            self:deleteCorruptFiles(path .. "/save.lua")

            self:generateFiles()
        end
    end

    self.files, circlePadEnabled = self:loadFile(self.path .. "/save.lua")
end

function SGM:catchError(func, arg)
    if love.system.getOS() == "Windows" then
        arg = arg:gsub("/", "\\")
    end

    return pcall(func, arg)
end

function SGM:loadFile(path)
    if love.system.getOS() == "Windows" then
        path = path:gsub("/", "\\")
    end

    return dofile(path)
end

function SGM:deleteCorruptFiles(path)
    if love.system.getOS() == "Windows" then
        path = path:gsub("/", "\\")
    end

    os.remove(path)
end

function SGM:open(path, mode)
    if love.system.getOS() == "Windows" then
        path = path:gsub("/", "\\")
    end

    print(path, mode)

    return io.open(path, mode)
end

function SGM:generateFiles()
    local file = self:open(self.path .. "/save.lua", "rb")

    if not file then
        file = self:open(self.path .. "/save.lua", "w")

        if file then
            file:write("return\n{\n\tnil,\n\tnil,\n\tnil\n}")

            file:flush()
                
            file:close()
        end
    end
end

function SGM:select(i)
    self.currentSave = i

    SPAWN_X, SPAWN_Y = self.files[i][6], self.files[i][7]
    currentScript = self.files[i][8]
end

function SGM:getMap()
    return self.files[self:getCurrentSave()][5]:gsub('"', "")
end

function SGM:generateSaveData() --hipsters..
    local date = os.date("%m.%d.%Y")
    if love.system.getModel() ~= "usa" then
        date = os.date("%d.%m.%Y")
    end

    return 
    {
        '"' .. tostring(date) .. '"', 
        objects["player"][1]:getHealth(), 
        objects["player"][1]:getMaxHealth(), 
        math.floor(self:getTime()),
        '"' .. tiled:getMapName() .. '"', 
        math.floor(objects["player"][1].x), 
        math.floor(objects["player"][1].y),
        currentScript
    }
end

function SGM:fixSaveData(i)
    self.files[i][1], self.files[i][5] = '"' .. self.files[i][1] .. '"', '"' .. self.files[i][5] .. '"'
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
                if self.files[i] ~= nil then
                    if i ~= self:getCurrentSave() then
                        self:fixSaveData(i)
                    end
                    
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