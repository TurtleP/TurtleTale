hud = class("hud")

function hud:init()
	self.x = 4
	self.y = 4

	self.timer = 0
	self.anim = {1, 2, 3, 2}

end

function hud:update(dt)
	self.timer = self.timer + 6.5 * dt
end

function hud:draw()
	if eventSystem and eventSystem:isRunning() then
		return
	end
	
	for x = 1, objects["player"][1]:getMaxHealth() do
		local offset, quadi = 0, 3
		if x % 2 == 0 then
			offset = 4
		end

		if x > objects["player"][1]:getHealth() then
			quadi = 4
		end

		if x == objects["player"][1]:getHealth() then
			quadi = self.anim[math.floor(self.timer % #self.anim) + 1]
		end

		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(healthImage, healthQuads[quadi], self.x + (x - 1) * 9, self.y + offset)
	end
end