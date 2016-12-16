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
                print(self.files[i])
                if self.files[i] ~= nil then
                    file:write("{'" .. self.files[i][1] .. "', " .. self.files[i][2] .. ", " .. self.files[i][3] .. ", " .. self.files[i][4] .. "},\n\t")
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

    self.files[i][3] = self.files[i][3] + dt
end

function SGM:getTime()
    return math.floor(self.files[self:getCurrentSave()][3])
end

function SGM:deleteData(i)
    --just gonna .. call the things n stuff
    self:save(i, nil)
end

function SGM:getSaveData(i)
    return self.files[i]
end

function SGM:getCurrentSave()
    if not self.currentSave then
        return
    end

    return self.currentSave
end

return SGM