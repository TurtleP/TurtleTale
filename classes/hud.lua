hud = class("hud")

function hud:init()
	self.x = 20
	self.y = 4

	self.timer = 0
	self.anim = {1, 2, 3, 2}

	self.fade = 1

	self.player = objects["player"][1]
	self.maxDelay = 1
	self.delay = self.maxDelay

	self.inventoryY = self.y
end

function hud:adjust()
	local x, offset = 20, 396
	if tiled:getWidth("top") < 25 then
		x = x - mapScroll
		offset = offset + mapScroll - x
	end
	self.x = x
	self.offset = offset

	self.inventoryX = self.x - 18
end

function hud:update(dt)
	self.timer = self.timer + 6.5 * dt
end

function hud:reset(isHurt)
	self.delay = self.maxDelay
	self.fade = 1
end

function hud:draw()
	local player = nil
	if objects["player"][1] then
		player = objects["player"][1]
	end

	for x = 1, player:getMaxHealth() do
		local offset, quadi = 0, 3
		if x % 2 == 0 then
			offset = 4
		end

		if x > player:getHealth() then
			quadi = 4
		end

		if x == player:getHealth() then
			quadi = self.anim[math.floor(self.timer % #self.anim) + 1]
		end

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(healthImage, healthQuads[quadi], self.x + (x - 1) * 9, self.y + offset)
	end

	love.graphics.setColor(128, 128, 128, 100)
	love.graphics.circle("fill", self.inventoryX + 8, self.inventoryY + 8, 8, 100)

	if player.inventory.itemLength > 0 then
		love.graphics.setColor(255, 255, 255, 255)
		if player.inventory:getItemCount(player.inventory:getCurrentItem(true)) == 0 then
			love.graphics.setColor(255, 255, 255, 150)
		end
		love.graphics.draw(inventoryIcons, inventoryIconQuads[player.inventory:getCurrentItem()], self.inventoryX, self.inventoryY)
	end

	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print("x", self.x - 9, self.y + 7)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("x", self.x - 8, self.y + 8)
end