house = class("house")

local houseImage = love.graphics.newImage("graphics/game/prefabs/house.png")
local houseQuads = {}
for i = 1, 2 do
	houseQuads[i] = love.graphics.newQuad(0, (i - 1) * 48, 128, 48, houseImage:getWidth(), houseImage:getHeight())
end

function house:initialize(layer, x, y)
	self.x = x
	self.y = y

	self.active = true
	self.static = true

	self.width = 128
	self.height = 48

	self.fade = 1

	table.insert(layer, self)

	self.door = door:new(layer, 208, 192, {link = "indoors;192;208"})
end

function house:fix()
	self.fade = 0
end

function house:update(dt)
	if self.fade > 0 then
		local flames = checkrectangle(self.x, self.y, self.width, self.height, {"fire"})

		if #flames > 0 then
			--if not self.burn then
				
				if math.random(100) < 30 then
					fire:new(state:get("layers")[3], math.random(self.x, self.x + self.width - 16), math.random(self.y, self.y + self.height - 16), vector(0, 0))
				end

				if not self.burn then
					state:call("addFixData", self, true)
				end

				self.burn = true
			--end
		end

		if self.burn then
			self.fade = math.max(self.fade - 0.15 * dt, 0)
		end
	else
		self.door.remove = true
	end
end

function house:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(houseImage, houseQuads[2], self.x, self.y)

	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.draw(houseImage, houseQuads[1], self.x, self.y)

	love.graphics.setColor(255, 255, 255, 255)
end