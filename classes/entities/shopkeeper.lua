shopkeeper = class("shopkeeper", entity)

local hermitImage = love.graphics.newImage("graphics/game/enemies/hermit.png")
local hermitQuads = {}
local hermitStates = {{"walk", 4}, {"idle", 4}, {"attack", 8}}
for y = 1, 3 do
	hermitQuads[hermitStates[y][1]] = {}
	for x = 1, hermitStates[y][2] do
		table.insert(hermitQuads[hermitStates[y][1]], love.graphics.newQuad((x - 1) * 16, (y - 1) * 16, 16, 16, hermitImage:getWidth(), hermitImage:getHeight()))
	end
end

local voicelines =
{
	["shop"] =
	{
		"Welcome to my shop, fam.",
		"Hmm do you have the money?"
	},
	["inn"] =
	{
		"You look tired. I can help you with that!",
		"Welcome. Sleep is good for you!"
	}
}

function shopkeeper:init(x, y, properties)
	entity.init(self, x, y)

	self.x = x
	self.y = y

	self.width = 12
	self.height = 16

	self.active = true

	self.gravity = 480

	self.mask = {true}

	self.timer = 0
	self.quadi = 1

	self.entity = "hermit"

	local lines = voicelines["shop"]
	if not properties.menu then
		lines = voicelines["inn"]
	end
	
	local speech = lines[math.random(#lines)]

	speech = speech .. " Step on the rock and press UP."

	local pass = cutscenes["shop"][2]
	if pass then
		self:speak(speech)
	end

	if properties.menu then
		self.menu = shopmenu:new(SHOP_DATA[tiled:getMapName()])
	end

	local x, y = self.x - (3 * 16), self.y + (2 * 16)
	if properties.noshop then
		x, y = self.x, self.y
	end

	self.shopUse = userectangle:new(x, y, 16, 16, function()
		if self.menu then
			if not SHOP_OPEN then
				self:speak("I got a lot to sell! Press X for more info about an item.")
				SHOP_OPEN = true
			end
		else
			gameNewDialog("hermit", "Would you like to take a rest for now?", nil, 
			{
				function()
					eventSystem:decrypt("heal", cutscenes["heal"][1])
					dialogs = {}
				end,

				function()
					dialogs = {}
					self:speak("Very well. See you soon, sir.")
					objects["player"][1]:freeze(false)
				end
			})
		end
		objects["player"][1]:freeze(true)
	end, true)
end

function shopkeeper:update(dt)
	self.shopUse:update(dt)

	self.timer = self.timer + 6 * dt
	self.quadi = math.floor(self.timer % #hermitQuads["idle"]) + 1

	if self.menu then
		self.menu:update(dt)
		
		if not SHOP_OPEN then
			if not eventSystem:isRunning() then
				objects["player"][1].frozen = false
			end
		end
	end

	if self.speaking and #dialogs == 0 then
		self.speaking = false
	end
end

function shopkeeper:draw()
	if not SHOP_OPEN and not self.speaking then
		self.shopUse:draw()
	end

	love.graphics.draw(hermitImage, hermitQuads["idle"][self.quadi], self.x, self.y)

	if self.menu then
		self.menu:draw()
	end
end

function shopkeeper:keypressed(key)
	if SHOP_OPEN then
		self.menu:keypressed(key)
	end
end