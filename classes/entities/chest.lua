chest = class("chest")

function chest:init(x, y, properties)
	self.x = x
	self.y = y

	self.width = 32
	self.height = 32

	self.quadi = 1
	self.timer = 0

	local item = nil
	if properties.item ~= nil then
		item = properties.item:split(";")
	end
	self.item = item

	local visible = true
	if properties.visible ~= nil then
		visible = properties.visible
	end
	self.visible = visible

	self.open = false

	self.active = true

	self.speedx = 0
	self.speedy = 0
	self.gravity = 0

	self.use = userectangle:new(self.x, self.y, self.width, self.height, function()
		if not self.open then
			if self.item then
				if self.item[1] == "coins" then
					fanfareSound:play()
					gameNewDialog(nil, "Obtained " .. self.item[2] .. " coins!")
					objects["player"][1]:addMoney(tonumber(self.item[2]))
				elseif self.item[1] == "key" then
					table.insert(prefabs, key:new(self.x + (self.width - 8) / 2, self.y))
				end
				fanfareSound:play()
				table.insert(MAP_DATA[tiled:getMapName()], {self.x, self.y, true})
			end
			self.open = true
		end
	end, false, true)
end

function chest:fix()
	self.quadi = 5
	self.use.remove = true
	self:setVisible(true)
end

function chest:setVisible(visible)
	self.visible = visible
end

function chest:update(dt)
	if not self.visible then
		return
	end

	if not self.open then
		self.use:update(dt)
	else
		if self.quadi < 5 then
			self.timer = self.timer + 8 * dt
			self.quadi = math.floor(self.timer % 5) + 1
		end
	end
end

function chest:draw()
	if not self.visible then
		return
	end

	love.graphics.draw(chestImage, chestQuads[self.quadi], self.x, self.y - 16)
	
	if not self.open then
		self.use:draw()
	end

	love.graphics.setColor(255, 255, 255)
end