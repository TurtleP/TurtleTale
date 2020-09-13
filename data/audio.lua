local audio = {}

-- music --
audio.Cliffs = love.audio.newSource("audio/music/cliffs.ogg", "stream")
audio.Title  = love.audio.newSource("audio/music/title.ogg", "stream")
-- sounds --
audio.Jump   = love.audio.newSource("audio/jump.ogg", "static")

-- current --
audio.current = ""

function audio.play(name)
    if name and audio.current ~= name then
        if not audio.current:empty() then
            audio[audio.current]:stop()
        end

        if not name:empty() and audio[name] then
            audio[name]:play()
        else
            print(string.format("failed to play audio: '%s'!", name))
        end

        audio.current = name
    end
end

function audio.playSound(name)
    if name and not name:empty() then
        if audio[name] then
            return audio[name]:play()
        end
        print(string.format("failed to play audio: '%s'!", name))
    end
end

return audio