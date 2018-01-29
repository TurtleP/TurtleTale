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
	["sky"] = {66, 148, 209},
	["indoors"] = {43, 19, 23}
}

function reloadData()
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

	print()

	CUTSCENES = {}
	local items = love.filesystem.getDirectoryItems("data/scenes")
	for i = 1, #items do
		if items[i]:hasExtension(".lua") then
			local value = items[i]:gsub(".lua", "")
			
			CUTSCENES[value] = {require("data.scenes." .. value), false}
			print("Cached cutscene: " .. value)
		end
	end

	print()

	MAP_DATA = {}

	SHOP_DATA = {}
	local items = love.filesystem.getDirectoryItems("data/shop")
	for i = 1, #items do
		if items[i]:hasExtension(".json") then
			local value = items[i]:gsub(".json", "")
			
			SHOP_DATA[value] = json:decode(love.filesystem.read("data/shop/" .. items[i]))
			print("Cached Shop data: " .. value)
		end
	end

	print()

	SHOP_ITEMS = {}
	local items = love.filesystem.getDirectoryItems("data/shop/items")
	for i = 1, #items do
		if items[i]:hasExtension(".lua") then
			local value = items[i]:gsub(".lua", "")
			
			SHOP_ITEMS[value] = require("data.shop.items." .. value)
			print("Cached Shop item: " .. value)
		end
	end

	print()
end

CREDITS =
{
	"A GAME BY TURTLEP",
	"",
	"",
	"",
	"",
	"== LIBRARIES ==",
	"middleclass.lua: Enrique Garcia Cota",
	"hook.lua: Christian Vallentin",
	"json.lua: Jeffrey Friedl",
	"vector.lua: Matthias Richter",
	"",
	"",
	"",
	"",
	"== ARTISTS ==",
	"Polybius",
	"Lime_Soda",
	"",
	"",
	"",
	"",
	"== MUSIC/SFX ==",
	"St. Happyfaces",
	"bfxr.net",
	"",
	"",
	"",
	"",
	"== BETA TESTERS ==",
	"916253",
	"Hatninja",
	"LiquidFenrir",
	"Noahkiq",
	"",
	"",
	"THIS GAME IS LICENSED UNDER",
	"ATTRIBUTION-NONCOMMERCIAL-SHAREALIKE",
	"4.0 INTERNATIONAL",
	"",
	"",
	"",
	"(c) 2018 TurtleP"
}

for i = 1, #CREDITS do
	local tmp = CREDITS[i]

	CREDITS[i] = { tmp, "bottom", SCREEN_HEIGHT }
end

SHOP_OPEN = false