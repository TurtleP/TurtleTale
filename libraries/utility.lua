local utility = {}

utility.print_r = function (t, indent) --Not by me
    local indent = indent or 0

    for key, value in pairs(t) do
        io.write(string.rep(" ", indent) .. '[' .. tostring(key) .. ']')

        if type(value) == "table" then
            io.write(':\n')
            Utility.Print_R(value, indent + 2)
        else
            io.write(' = ' .. tostring(value) .. '\n')
        end
    end
end

function string:split(delimiter) --Not by me
    local result = {}
    local from  = 1
    local delim_from, delim_to = string.find( self, delimiter, from  )
    while delim_from do
        table.insert( result, string.sub( self, from , delim_from-1 ) )
        from = delim_to + 1
        delim_from, delim_to = string.find( self, delimiter, from  )
    end
    table.insert( result, string.sub( self, from  ) )
    return result
end

function math.clamp(x, lo, hi)
    return math.max(lo, math.min(hi, x))
end

function string:replace(position, replace)
    return self:sub(1, position - 1) .. replace .. self:sub(position + 1)
end

utility.hexColor = function(str)
    str = tostring(str)

    str = str:gsub("#", "")

    local out = {}
    for i = 1, #str, 2 do
        table.insert(out, tonumber(str:sub(i, i + 1), 16))
    end

    return {love.math.colorFromBytes(unpack(out))}
end

utility.colorFade = function(now, max, color, blend) --Color function, HugoBDesigner
    local tp = now / max
    local ret = {} --returned color

    for i = 1, #color do
        ret[i] = math.max(0, math.min(color[i] + (blend[i] - color[i]) * tp, 1))
    end

    return ret
end

return utility
