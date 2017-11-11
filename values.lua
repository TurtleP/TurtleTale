jumpForce = 2 * 60
jumpForceAdd = 1 * 60

currentScript = 1

SPAWN_X = 0
SPAWN_Y = 0
LAST_SAVE_LOCATION = {nil, nil, nil}

chargeEasterEgg = false
circlePadEnabled = false

turtlePunchDuration = 0.75
turtlePunchForce = 80
turtleInvincible = false
turtleGravity = 360

waterGunForce = 100

controls =
{
	["left"] = "left",
	["right"] = "right",
	["up"] = "up",
	["down"] = "down",
	["jump"] = "b",
	["punch"] = "y"
}

ITEM_NAMES =
{
	"water",
	"rope",
	"wax",
	"bubble"
}

--SHOPS
SHOP_OPEN = false

SHOP_DATA = {}
local shops = love.filesystem.getDirectoryItems("data/shop")
for i = 1, #shops do
	local name = shops[i]:gsub(".json", "")
	if name:find("shop") then
		SHOP_DATA[name] = json:decode(love.filesystem.read("data/shop/" .. shops[i])) --{"heart", false}
	end
end

SHOP_ITEMS = {}
local items = love.filesystem.getDirectoryItems("data/shop/items")
for i = 1, #items do
	local name = items[i]:gsub(".lua", "")
	SHOP_ITEMS[name] = require("data.shop.items." .. name)
end

--CUTSCENES
cutscenes = {}
local items = love.filesystem.getDirectoryItems("data/scenes")
for k, v in ipairs(items) do
	local name = v:gsub(".lua", "")
	cutscenes[name] = {require('data.scenes.' .. name), false}
end

--HIDDEN ITEMS
HIDDEN_ITEMS = {}
local items = require('data.hidden')
for name, data in pairs(items) do
	HIDDEN_ITEMS[name] = data
end

--LOAD EVENTS
function LOAD_EVENTS()
	for k, v in pairs(cutscenes) do
		v[2] = false
	end

	for k, v in pairs(HIDDEN_ITEMS) do
		for j, w in ipairs(v) do
			w.used = false
		end
	end
end

MAP_DATA = {}

function loadFont()
	if not gameFont then
		if _EMULATEHOMEBREW or _RELEASE then
			gameFont = love.graphics.newFont("graphics/Gohu.ttf", 14)
		else
			gameFont = love.graphics.newFont("graphics/Gohu.10")
		end
	end
end