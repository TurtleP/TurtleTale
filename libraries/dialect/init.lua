local PATH = (...):gsub('%.init$', '')

local dialect = require(PATH .. ".dialect")

dialect.images = {}
dialect.messages = {}

local function scanDirectory(dir, exts)
    local currentDirectory = PATH:gsub("%.", "/") .. "/" .. dir

    local files = love.filesystem.getDirectoryItems(currentDirectory)

    local function item_in(table, item)
        for _, value in ipairs(table) do
            if value == item then
                return true
            end
        end
        return false
    end

    local ret = {}
    for i = 1, #files do
        if item_in(exts, files[i]:sub(-4)) then
            local name = files[i]:sub(0, files[i]:find("%.") - 1)
            table.insert(ret, {name = name, path = currentDirectory .. "/" .. files[i]})
        end
    end

    return ret
end

for _, value in pairs(scanDirectory("messages", {".txt"})) do
    dialect.messages[value.name] = love.filesystem.read(value.path)
end

PATH = PATH:gsub("%.", "/")

dialect.images.default = love.graphics.newImage(PATH .. "/default.png")

for _, value in pairs(scanDirectory("profiles", {".png"})) do
    dialect.images[value.name] = love.graphics.newImage(value.path)
end

dialect.pauseChar = "|"

return dialect
