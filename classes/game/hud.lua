hud = class("hud")

local inventoryBackImage = love.graphics.newImage("graphics/hud/inventory.png")

function hud:initialize(player)
	self.x = 2
	self.y = 2

	self.player = player
	self.timer = 0

	self.heartAnimation = {1, 2, 3, 2}
end

function hud:update(dt)
	self.timer = self.timer + 6.5 * dt
end

function hud:draw()
	love.graphics.draw(inventoryBackImage, self.x, self.y)
	
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("x", self.x + 15 - gameFont:getWidth("x"), self.y + 7)
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("x", self.x + 16 - gameFont:getWidth("x"), self.y + 8)

	
	for i = 1, self.player.maxHealth do
		local quadi, add = 3, 0
		if i > self.player.health then
			quadi = 4
		elseif i == self.player.health then
			quadi = self.heartAnimation[math.floor(self.timer % #self.heartAnimation) + 1]
		end

		if i % 2 == 0 then
			add = 4
		end

		love.graphics.draw(healthImage, healthQuads[quadi], self.x + 18 + (i - 1) * 9, self.y + add)
	end
end