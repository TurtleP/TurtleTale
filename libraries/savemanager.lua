local SGM = {}

function SGM:init()
    local path = ""
    if not _EMULATEHOMEBREW then
        path = "sdmc:/LovePotion/TurtleTale"
    end

    self.path = path

    if not love.filesystem.isFile(path .. "/save.lua") then
        file = love.filesystem.newFile(path .. "/save.lua", "w")

        file:write("return\n{\n\tnil,\n\tnil,\n\tnil\n}")
    end

    self.currentSave = nil

    local files = nil
    if love.filesystem.isFile(path .. "/save.lua") then
        files = require 'save'
    end

    self.files = files 
end

function SGM:save(t, toSave)
    if self.files then
        self.files[t] = toSave

        self.currentSave = t

        love.filesystem.remove(self.path .. "/save.lua")

        file = love.filesystem.newFile(self.path .. "/save.lua", "w")
        file:write("return\n{\n\t")

        for i = 1, #self.files do
            file:write("{'" .. self.files[i][1] .. "', " .. self.files[i][2] .. ", " .. self.files[i][3] .. "},\n\t")
        end

        file:write("\n}")
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