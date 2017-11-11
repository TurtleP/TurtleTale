local util = {}

--[[
	util.lua

	Useful Tool in Love

	TurtleP

	v2.0
--]]

local scale = {1, 1}

function util.changeScale(scalar)
	scale = scalar

	love.window.setMode(love.graphics.getWidth() * scalar, love.graphics.getHeight() * scalar)
end

function util.round(num, idp) --Not by me
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

function util.toBoolean(stringCompare)
	return tostring(stringCompare) == "true"
end

function util.setScalar(xScale, yScale)
	scale = {xScale, yScale}
end

function util.changeState(toState, ...)
	local arg = {...} or {}

	if _G[toState .. "Init"] then
		state = toState
		_G[toState .. "Init"](unpack(arg))
	end

end

function util.lerp(a, b, t) 
	return (1 - t) * a + t * b 
end

function util.print_r(t, indent) --Not by me
	local indent = indent or ''
	for key, value in pairs(t) do
		io.write(indent, '[', tostring(key), ']') 
		if type(value) == "table" then 
			io.write(':\n') 
			print_r(value, indent .. '\t')
		else 
			io.write(' = ', tostring(value), '\n') 
		end
	end
end

function util.convertTime(seconds)
	local floor = math.floor
	
	local minutes = floor(seconds / 60)
	minutes = floor(minutes % 60)
	
	local hours = floor(minutes / 60)

	return string.format("%02d:%02d", hours, minutes)
end

function util.updateState(dt)
	if _G[state .. "Update"] then
		_G[state .. "Update"](dt)
	end
end

function util.renderState()
	if _G[state .. "Draw"] then
		_G[state .. "Draw"]()
	end
end

function util.keyPressedState(key)
	if _G[state .. "KeyPressed"] then
		_G[state .. "KeyPressed"](key)
	end
end

function util.keyReleasedState(key)
	if _G[state .. "KeyReleased"] then
		_G[state .. "KeyReleased"](key)
	end
end

function util.mousePressedState(x, y, button)
	if _G[state .. "MousePressed"] then
		_G[state .. "MousePressed"](x, y, button)
	end
end

function util.mouseReleasedState(x, y, button)
	if _G[state .. "MouseReleased"] then
		_G[state .. "MouseReleased"](x, y, button)
	end
end

function util.textInput(text)
	if _G[state .. "TextInput"] then
		_G[state .. "TextInput"](text)
	end
end

function util.mouseMovedState(x, y, dx, dy)
	if _G[state .. "MouseMoved"] then
		_G[state .. "MouseMoved"](x, y, dx, dy)
	end
end

function util.gamePadPressed(joystick, button)
	if _G[state .. "GamePadPressed"] then
		_G[state .. "GamePadPressed"](joystick, button)
	end
end

function util.gamePadReleased(joystick, button)
	if _G[state .. "GamePadReleased"] then
		_G[state .. "GamePadReleased"](joystick, button)
	end
end

function util.touchPressed(id, x, y, pressure)
	if _G[state .. "TouchPressed"] then
		_G[state .. "TouchPressed"](id, x, y, pressure)
	end
end

function util.touchReleased(id, x, y, pressure)
	if _G[state .. "TouchReleased"] then
		_G[state .. "TouchReleased"](id, x, y, pressure)
	end
end

function util.touchMoved(id, x, y, dx, dy, pressure)
	if _G[state .. "TouchMoved"] then
		_G[state .. "TouchMoved"](id, x, y, dx, dy, pressure)
	end
end

function util.dist(x1,y1, x2,y2) 
	return ((x2-x1)^2+(y2-y1)^2)^0.5 
end

function util.clamp(val, min, max)
	return math.max(min, math.min(val, max))
end

function util.colorFade(currenttime, maxtime, c1, c2) --Color function
	local tp = currenttime/maxtime
	local ret = {} --return color

	for i = 1, #c1 do
		ret[i] = c1[i]+(c2[i]-c1[i])*tp
		ret[i] = math.max(ret[i], 0)
		ret[i] = math.min(ret[i], 255)
	end

	return ret
end

function util.getWidth()
	if _EMULATEHOMEBREW then
		if love.graphics.getScreen() == "bottom" then
			return 320
		end
	end
	return 400
end

function util.getHeight()
	return 240
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

function string:replace(position, replace)
	return self:sub(1, position - 1) .. replace .. self:sub(position + 1)
end

Color =
{
	["red"] = {225, 73, 56},
	["green"] = {65, 168, 95},
	["blue"] = {44, 130, 201},
	["yellow"] = {250, 197, 28},
	["orange"] = {243, 121, 52},
	["purple"] = {147, 101, 184},
	["darkPurple"] = {85, 57, 130},
	["black"] = {0, 0, 0},
	["white"] = {255, 255, 255}
}

return util
