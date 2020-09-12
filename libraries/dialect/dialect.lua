local dialect = {}

dialect.CONST_PADDING = 4
dialect.CORNER_RADIUS = 0

dialect.timers =
{
    time = nil,
    max = nil,

    lifeTime = 0,
    endTime = 3,

    pauseTime = 0,
    maxPause = 1
}

dialect.colors =
{
    title = {1, 1, 1},
    text  = {1, 1, 1}
}

dialect.text =
{
    speaker = "",
    speakers = {},

    avatar = nil,
    avatars = {},

    render  = "",
    cache   = {},

    font    = nil,

    index   = 1,
    current = 1
}

dialect.buttons =
{
    continue = {key = "space", joy = "a"},
    choiceUp = {key = "up", joy = "dpup"},
    choiceDown = {key = "down", joy = "dpdown"}
}

dialect.speeds =
{
    normal = 0.01,
    medium = 0.05,
    slow   = 0.08
}

dialect.CONST_BOX_HEIGHT = 136
dialect.CONST_NO_SPEAKER = ""

dialect.position =
{
    text =
    {
        dialect.CONST_PADDING,
        love.graphics.getHeight() - (dialect.CONST_BOX_HEIGHT + dialect.CONST_PADDING),
        love.graphics.getWidth() - (dialect.CONST_PADDING * 2),
        dialect.CONST_BOX_HEIGHT,
        dialect.CORNER_RADIUS,
        dialect.CORNER_RADIUS
    }
}

dialect.flags =
{
    choose = false,
    waitForInput = false,
    running = false,
    paused = false
}

dialect.triggers =
{
    onStart = nil,
    onFinish = nil
}

dialect.audio =
{
    writeSound = nil
}

local function generateTitleBox()
    if not dialect.text.speaker then
        return
    end

    dialect.position.title =
    {
        dialect.CONST_PADDING,
        dialect.position.text[2] - (dialect.text.font:getHeight() + dialect.CONST_PADDING) - dialect.CONST_PADDING / 2,
        dialect.text.font:getWidth(dialect.text.speaker) + (2 * dialect.CONST_PADDING),
        dialect.text.font:getHeight() + dialect.CONST_PADDING
    }
end

local utf8 = require("utf8")

local function wordWrap(text, config)
    local limit = dialect.position.text[3]
    local MAX_LINES = math.floor(dialect.CONST_BOX_HEIGHT / dialect.text.font:getHeight())

    if config.profile then
        limit = limit - 128
    end

    limit = limit - dialect.CONST_PADDING
    limit = limit - dialect.text.font:getWidth(">>")

    local line  = ""
    local ret = {}

    local function check(s)
        return dialect.text.font:getWidth(s) >= limit
    end

    for word, spaces in text:gmatch("(%S+)(%s*)") do
        local s = line .. word

        if check(s) then
            table.insert(ret, line .. "\n")
            line = word
        else
            line = s
        end

        for c in spaces:gmatch(".") do
            if c == "\n" then
                table.insert(ret, line .. "\n")
                line = ""
            else
                line = line .. c
            end
        end
    end

    table.insert(ret, line)

    return table.concat(ret)
end

local function getProfileIcon(config)
    if not config.profile then
        -- config doesn't exist--insert nil
        table.insert(dialect.text.avatars, dialect.CONST_NO_SPEAKER)
        return
    end

    -- use default image if profile isn't nil, but doesn't exist
    local item = dialect.images.default
    if dialect.images[config.profile] then
        -- use specified image if profile isn't nil and exists
        item = dialect.images[config.profile]
    end

    table.insert(dialect.text.avatars, item)
end

function dialect.updateIcon()
    dialect.text.avatar = dialect.text.avatars[dialect.text.current]
end

function dialect.updateSpeaker()
    if not dialect.text.speakers[dialect.text.current] then
        return
    end

    dialect.text.speaker = dialect.text.speakers[dialect.text.current]

    generateTitleBox()
end

function dialect.setTextboxDimensions(x, y, width, height)
    dialect.position.text = {x, y, width, height}
end

function dialect.setFont(font)
    assert(type(font) == "userdata", "Font expected, got " .. type(font))

    dialect.text.font = font
    generateTitleBox()
    dialect.CONST_MAX_LINES = math.floor(dialect.position.text[4] / dialect.text.font:getHeight())
end

function dialect.setSounds(t)
    for key, value in pairs(t) do
        if dialect.audio[key] then
            if type(value) == "userdata" then
                dialect.audio[key] = value
            else
                dialect.audio[key] = love.audio.newSource(value, "static")
            end
        end
    end
end

function dialect.setDelay(amount)
    if type(amount) == "string" then
        dialect.timers.time = dialect.speeds[amount]
    else
        dialect.timers.time = amount
    end

    dialect.timers.max = dialect.timers.time
end

function dialect.isWaitingForInput()
    return dialect.flags.waitForInput
end

function dialect.isRunning()
    return dialect.flags.running
end

function dialect.speak(speaker, text, config)
    local config = config or {}

    -- this is all hacky, kinda
    -- the cache/speakers/profile arrays should be the same length
    -- so it doesn't error
    -- there's likely a way better way to handle it, but meh
    if type(text) == "string" then
        table.insert(dialect.text.speakers, speaker or "")

        getProfileIcon(config)

        local item = wordWrap(text, config)
        if dialect.messages[text] then
            item = wordWrap(dialect.messages[text], config)
        end

        table.insert(dialect.text.cache, item)
    else
        for i = 1, #text do
            getProfileIcon(config)

            table.insert(dialect.text.cache, wordWrap(text[i], config))
            table.insert(dialect.text.speakers, speaker)
        end
    end

    dialect.flags.running = true

    if dialect.triggers.onStart then
        dialect.trigger.onStart()
    end

    dialect.updateSpeaker()
    dialect.updateIcon()
end

local punctuation = {".", "?", "!"}
local function isPunctuation(char)
    for i = 1, #punctuation do
        if char == punctuation[i] then
            return true
        end
    end
    return false
end

dialect.lines = 0
local function countIfNewline(char)
    if char ~= "\n" then
        return
    end

    dialect.lines = dialect.lines + 1
end

function dialect.update(dt)
    if not dialect.flags.running then
        return
    end

    local currentString = dialect.text.cache[dialect.text.current]

    if dialect.text.current <= #dialect.text.cache then
        if dialect.text.index <= #currentString then
            if dialect.flags.paused then
                dialect.timers.pauseTime = dialect.timers.pauseTime + dt
                if dialect.timers.pauseTime > dialect.timers.maxPause then
                    dialect.timers.pauseTime = 0
                    dialect.flags.paused = false
                end
                return
            end

            if dialect.flags.waitForInput then
                return
            end

            if dialect.timers.time <= dialect.timers.max then
                dialect.timers.time = dialect.timers.time + dt
            else
                local char = currentString:sub(dialect.text.index, dialect.text.index)

                local preChar = char
                if char == dialect.pauseChar then
                    char = " "
                end

                dialect.text.render = dialect.text.render .. char

                countIfNewline(char)

                dialect.text.index = dialect.text.index + 1

                if dialect.audio.writeSound then
                    dialect.audio.writeSound:play()
                end

                if preChar == dialect.pauseChar or isPunctuation(char) then
                    dialect.flags.paused = true
                elseif dialect.lines > 0 and (dialect.lines % dialect.CONST_MAX_LINES == 0) then
                    if char == "\n" then
                        dialect.flags.waitForInput = true
                    end
                end

                dialect.timers.time = 0
            end
        else
            dialect.flags.waitForInput = true
        end
    else
        dialect.timers.lifeTime = dialect.timers.lifeTime + dt
        if dialect.timers.lifeTime > dialect.timers.endTime then
            if dialect.triggers.onFinish then
                dialect.trigger.onFinish()
            end
            dialect.flags.running = false
        end
    end
end

function dialect.draw()
    if not dialect.flags.running then
        return
    end

    love.graphics.setFont(dialect.text.font)

    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.rectangle("fill", unpack(dialect.position.text))

    local textBox = dialect.position.text

    love.graphics.setColor(1, 1, 1, 1)

    local add = 0

    -- speaker cannot be an empty string -- hacky solution
    if dialect.text.avatar ~= dialect.CONST_NO_SPEAKER and dialect.text.avatar then
        add = dialect.text.avatar:getWidth() + dialect.CONST_PADDING
        love.graphics.draw(dialect.text.avatar, textBox[1] + dialect.CONST_PADDING, textBox[2] + dialect.CONST_PADDING)
    end

    love.graphics.setColor(dialect.colors.text)
    love.graphics.print(dialect.text.render, textBox[1] + dialect.CONST_PADDING + add, textBox[2] + dialect.CONST_PADDING)

    if dialect.flags.waitForInput then
        love.graphics.print(">>", textBox[1] + textBox[3] - ((dialect.text.font:getWidth(">>") + dialect.CONST_PADDING * 2)) + math.cos(love.timer.getTime() * 4) * 4, textBox[2] + (textBox[4] - (dialect.text.font:getHeight() + dialect.CONST_PADDING)))
    end

    -- speaker cannot be an empty string
    if dialect.text.speaker == dialect.CONST_NO_SPEAKER then
        return
    end

    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.rectangle("fill", unpack(dialect.position.title))

    love.graphics.setColor(dialect.colors.title)

    local titleBox = dialect.position.title
    love.graphics.print(dialect.text.speaker, titleBox[1] + (titleBox[3] - dialect.text.font:getWidth(dialect.text.speaker)) / 2, titleBox[2] + (titleBox[4] - dialect.text.font:getHeight()) / 2)
end

function dialect.advanceText()
    dialect.timers.pauseTime = 0
    dialect.flags.paused = false

    local prevSpeaker = dialect.text.speaker

    if not dialect.text.cache[dialect.text.current] then
        return
    end

    if dialect.text.index >= #dialect.text.cache[dialect.text.current] then
        dialect.text.current = dialect.text.current + 1
        dialect.text.index = 1
        dialect.updateSpeaker()
    end

    local newSpeaker = dialect.text.speaker

    if dialect.text.cache[dialect.text.current] then
        dialect.text.render = ""
        dialect.updateIcon()
    end

    dialect.timers.time = 0
    dialect.flags.waitForInput = false
end

function dialect.quickUpdate()
    dialect.flags.paused = false
    dialect.text.render = dialect.text.cache[dialect.text.current]:gsub("␣", " ")
    dialect.text.index = #dialect.text.cache[dialect.text.current] + 1
end

function dialect.keyreleased(button)
    if not dialect.flags.waitForInput then
        return
    end

    if button == dialect.buttons.continue.key then
        dialect.advanceText()
    end
end

function dialect.gamepadreleased(button)
    if not dialect.flags.waitForInput then
        return
    end

    if button == dialect.buttons.continue.joy then
        dialect.advanceText()
    end
end

dialect.setDelay("normal")
dialect.setFont(love.graphics.newFont(14))

return dialect
