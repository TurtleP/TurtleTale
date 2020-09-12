local animation = {}

animation.scripts = {}

animation.CONST_DATA_PATH = "data/animations"

local dialect = require("libraries.dialect")

if love.filesystem.getInfo(animation.CONST_DATA_PATH) then
    local items = love.filesystem.getDirectoryItems(animation.CONST_DATA_PATH)

    for i = 1, #items do
        local name = items[i]:gsub(".lua", "")
        animation.scripts[name] = require("data.animations." .. name)
    end
end

function animation.update(dt)
    if not animation.current then
        return
    end

    if animation.index < #animation.current then
        if dialect.isRunning() then
            animation.sleep = dt
        end

        if animation.sleep > 0 then
            animation.sleep = math.max(animation.sleep - dt, 0)
            return
        end

        animation.index = animation.index + 1

        print(animation.index)

        local data = animation.current[animation.index]
        local command, args = data[1], data[2]

        if command == "wait" or command == "sleep" then
            animation.sleep = data[2]
        elseif command == "flash" then

        elseif command == "create" then

        elseif command == "unflash" then

        elseif command == "setplayer" then

        elseif command == "speak" or command == "dialog" then
            state.call("addDialog", args[1], args[2], args[3])
        elseif command == "playsound" then
            local audio = love.audio.newSource(animation.CONST_DATA_PATH .. "/" .. args[1], "static")
            audio:play()
        end
    end
end

function animation.start(name)
    if not animation.scripts[name] then
        print(string.format("failed to load script '%s': no such file!", name))
        return
    end

    animation.index = 0
    animation.sleep = 0

    animation.current = animation.scripts[name]
end

return animation
