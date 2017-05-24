chest = class("chest")

function chest:init(x, y, properties)
	self.x = x
	self.y = y

	self.width = 32
	self.height = 32

	self.quadi = 1
	self.timer = 0

	self.openi = 1

	self.item = properties.item:split(";")

	self.open = false

	self.active = true

	self.speedx = 0
	self.speedy = 0
	self.gravity = 0
end

function chest:update(dt)
	local ret = checkrectangle(self.x, self.y - 16, self.width, self.height, {"player"}, self)

	self.render = #ret > 0

	if not self.render then
		return
	else
		if not self.open then
			if ret[1][2].useKey then
				self.timer = 0

				if self.item[1] == "dialog" then
					gameNewDialog(self.item[2], self.item[3])
				end

				self.open = true
			end

			self.timer = self.timer + 12 * dt
			self.quadi = math.floor(self.timer % 8) + 1
		else
			if self.openi < 5 then
				self.timer = self.timer + 8 * dt
				self.openi = math.floor(self.timer % 5) + 1
			end
		end
	end

	
end

function chest:draw()
	love.graphics.draw(chestImage, chestQuads[self.openi], self.x, self.y - 16)
	
	if not self.render then
		return
	end

	if not self.open then
		love.graphics.setColor(0, 0, 0)
		love.graphics.draw(selectionVerImage, selectionVerQuads[self.quadi], (self.x + (self.width / 2)) - 6, (self.y - 19) + math.sin(love.timer.getTime() * 4))

		love.graphics.setColor(255, 0, 0)
		love.graphics.draw(selectionVerImage, selectionVerQuads[self.quadi], (self.x + (self.width / 2)) - 5, (self.y - 18) + math.sin(love.timer.getTime() * 4))
	end


	love.graphics.setColor(255, 255, 255)
end