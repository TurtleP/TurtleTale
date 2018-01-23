TOPSCREEN_WIDTH = 400
BOTSCREEN_WIDTH = 320
SCREEN_HEIGHT = 240
PLAYERSPAWN = {0, 0}

--jump stuff in blocks??
JUMPFORCE = 2 * 60
JUMPFORCEADD = 1 * 60

CONTROLS =
{
	["left"] = "left",
	["right"] = "right",
	["jump"] = "b",
	["duck"] = "down",
	["punch"] = "y",
	["use"] = "up"
}

BACKGROUNDCOLORS = 
{
	["midnight"] = {16, 51, 90},
	["sky"] = {107,161,228},
	["indoors"] = {43, 19, 23}
}

MAPS = {}
local items = love.filesystem.getDirectoryItems("data/maps")
for i = 1, #items do
	if love.filesystem.isFile("data/maps/" .. items[i]) then
		if items[i]:hasExtension(".lua") then
			local value = items[i]:gsub(".lua", "")
			
			MAPS[value] = require("data.maps." .. value)
			print("Cached map: " .. value)
		end
	end
end

CUTSCENES = {}
local items = love.filesystem.getDirectoryItems("data/scenes")
for i = 1, #items do
	if items[i]:hasExtension(".lua") then
		local value = items[i]:gsub(".lua", "")
		
		CUTSCENES[value] = {require("data.scenes." .. value), false}
		print("Cached cutscene: " .. value)
	end
end

MAP_DATA = {}