local state =
{
    _VERSION     = "0.1.0",
    _DESCRIPTION = "State Registry and Utility Library",
    _LICENSE     =
    [[
        MIT LICENSE

        Copyright (c) 2020 Jeremy S. Postelnek / TurtleP

        Permission is hereby granted, free of charge, to any person obtaining a
        copy of this software and associated documentation files (the
        "Software"), to deal in the Software without restriction, including
        without limitation the rights to use, copy, modify, merge, publish,
        distribute, sublicense, and/or sell copies of the Software, and to
        permit persons to whom the Software is furnished to do so, subject to
        the following conditions:

        The above copyright notice and this permission notice shall be included
        in all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
        OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
        IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
        CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
        TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
        SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]]
}

state.ERRORS = {}

state.ERRORS.EXIST   = "Failed to load State '%s' does not exist!"
state.ERRORS.INVALID = "Failed to load State '%s'! (didn't return its table?)"
state.ERRORS.LOAD    = "Failed to load State '%s'! (no load function?)"

state.ERRORS.SEARCH  = "Failed to find states ('states' directory is empty?)"
state.ERRORS.NO_DIR  = "Failed to get 'states' directory info (directory doesn't exist?)"

state.states  = {}
state.current = nil

state.unloading = false

if love.filesystem.getInfo("states") then
    local items = love.filesystem.getDirectoryItems("states")

    assert(#items > 0, state.ERRORS.SEARCH)

    for i = 1, #items do
        local name = items[i]:gsub(".lua", "")
        state.states[name] = require("states." .. name)
    end
else
    error(state.ERRORS.NO_DIR)
end

-- UPDATE & DRAW CALLBACKS --

function state.isCurrentStateValid(funcname)
    local hasState = (state.current ~= nil)

    if funcname == "unload" then
        state.unloading = true
    end

    if not hasState then
        return false
    end

    local hasFunction = state.current[funcname]
    local isUnloading = state.unloading

    if not hasFunction or isUnloading then
        return false
    end

    return true
end

function state.update(dt)
    if not state.isCurrentStateValid("update") then
        return
    end

    state.current:update(dt)
end

function state.draw()
    if not state.isCurrentStateValid("draw") then
        return
    end

    state.current:draw()
end

-- GAMEPAD CALLBACKS --

function state.gamepadpressed(joy, button)
    if not state.isCurrentStateValid("gamepadpressed") then
        return
    end

    state.current:gamepadpressed(joy, button)
end

function state.gamepadreleased(joy, button)
    if not state.isCurrentStateValid("gamepadreleased") then
        return
    end

    state.current:gamepadreleased(joy, button)
end

function state.gamepadaxis(joy, axis, value)
    if not state.isCurrentStateValid("gamepadaxis") then
        return
    end

    state.current:gamepadaxis(joy, axis, value)
end

-- [[ OTHER STUFF ]] --

function state.call(func, ...)
    local args = {...}

    if state.current[func] then
        local ret = state.current[func](state.current, unpack(args))

        if ret then
            return ret
        end
    end
end

function state.get(field)
    return state[field]
end

function state.set(field, value)
    state.current[field] = value
end

function state.unload()
    if state.isCurrentStateValid("unload") then
        state.current:unload()
    end
end

function state.load(which, ...)
    local arg = {...}

    assert(state.states[which], state.ERRORS.EXIST:format(which))

    assert(type(state.states[which]) ~= "boolean", state.ERRORS.INVALID:format(which))
    assert(state.states[which].load and type(state.states[which].load) == "function", state.ERRORS.LOAD:format(which))

    state.current:load(unpack(arg))
end

function state.switch(which, ...)
    state.unload()

    state.current = state.states[which]

    state.load(which, ...)

    state.unloading = false
end

return state
