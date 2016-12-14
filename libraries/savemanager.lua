local SGM = {}

function SGM:init()
    local path = "sdmc:/LovePotion/TurtleTale"
    if _EMULATEHOMEBREW then
        path = love.filesystem.getSaveDirectory() 
    end

    self.path = path

    local file = io.open(path .. "/save.lua", "w")
    if file then
        file:write("return\n{\n\tnil,\n\tnil,\n\tnil\n}")

        file:flush()
            
        file:close()
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

        love.filesystem.remove(self.path .. "/save.lua")

        file = io.open(self.path .. "/save.lua", "w")
        
        if file then
            file:write("return\n{\n\t")

            for i = 1, #self.files do
                file:write("{'" .. self.files[i][1] .. "', " .. self.files[i][2] .. ", " .. self.files[i][3] .. "},\n\t")
            end

            file:write("\n}")

            file:flush()
            file:close()
        end
    end
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