house = class("house")

local homeImage = love.graphics.newImage("graphics/game/home.png")
local homeQuads = {}
for i = 1, 2 do
	homeQuads[i] = love.graphics.newQuad(0, (i - 1) * 48, 128, 48, homeImage:getWidth(), homeImage:getHeight())
end

function house:init(x, y)
	self.x = x
	self.y = y

	self.width = 128
	self.height = 48

	self.burn = false--cutscenes["phoenix"][2]

	local fade = 0
	if self.burn then
		fade = 1
	end
	self.fade = fade

	self.door = door:new(208, 192, {link = "indoors", x = 192, y = 208})
	self.flames = {}
end

function house:update(dt)
	if cutscenes["phoenix"][2] then
		return
	end

	if not self.burn then
		self.door:update(dt)
	end

	local ret = checkrectangle(self.x, self.y, self.width, self.height, {"fireball"})
	if #ret > 0 then
		local rand = math.random(100)

		if rand < 30 then
			table.insert(self.flames, fireball:new(math.random(self.x, self.x + self.width - 16), math.random(self.y, self.y + self.height - 16), {0, 0}))
		end

		self.burn = true
	end

	for j, w in ipairs(self.flames) do
		w:update(dt)
	end

	if self.burn then
		self.fade = math.min(self.fade + 0.15 * dt, 1)
	end
end

function house:draw()
	love.graphics.draw(homeImage, homeQuads[1], self.x, self.y)

	if not self.burn then
		self.door:draw()
	end

	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.draw(homeImage, homeQuads[2], self.x, self.y)
	
	for j, w in ipairs(self.flames) do
		w:draw()
	end

	love.graphics.setColor(255, 255, 255, 255)
end

function house:setBurnt(burnt)
	self.burn = burnt

	if burnt then
		self.fade = 1
	end
	self.fade = 0
end