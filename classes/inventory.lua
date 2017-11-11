inventory = class("inventory")

function inventory:init()
	self.backFade = 0.5
	self.foreFade = 1

	self.powerTime = 0
	self.powerInfo = {love.system.getPowerInfo()}

	self.items = saveManager:getSaveData().inventory or {}

	self.itemi = 1

	local i = 0
	for j, v in pairs(self.items) do
		i = i + 1
	end
	self.itemLength = i

	print(self.itemLength)
	self.checkDir = nil
end

function inventory:update(dt)
	self.powerTime = self.powerTime + dt
	if self.powerTime > 30 then
		self.powerInfo = {love.system.getPowerInfo()}

		self.powerTime = 0
	end
end

function inventory:draw()
	love.graphics.setScreen("bottom")

	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill", 0, 0, 320, 240)

	love.graphics.setColor(255, 255, 255, 255 * self.backFade)
	love.graphics.draw(inventoryImage)

	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.draw(batteryImage, 2, 2)
	
	love.graphics.rectangle("fill", 4, 4, (self.powerInfo[2] / 100) * 13, 5)

	local money = objects["player"][1]:getMoney()
	love.graphics.print(money, love.graphics.getWidth() - 2 - (gameFont:getWidth(money) + 1), 8 - gameFont:getHeight() / 2 - 1)

	love.graphics.draw(shellImage, shellQuads[3], love.graphics.getWidth() - 2 - shellImage:getWidth() - (gameFont:getWidth(money) + 4), 3)
end

function inventory:addItem(item, count)
	if not self.items[item] then
		self.items[item] = 0
	end

	if not count then
		count = 1
	end

	self.items[item] = util.clamp(self.items[item] + count, 0, 99)
end

function inventory:getCurrentItem(isName)
	for k, v in pairs(self.items) do
		if ITEM_NAMES[self.itemi] == k then
			if not isName then
				return self.itemi
			else
				return k
			end
		end
	end
end

function inventory:getItemCount(name)
	return self.items[name]
end

function inventory:getItems()
	return self.items
end

function inventory:checkItem(step)
	if not inventoryIconQuads[self:getCurrentItem()] then
		self.itemi = self.itemi + step
		self:checkItem(step)
	end
end

function inventory:keypressed(key)
	if self.itemLength > 0 then
		if key == "lbutton" then
			self.itemi = self.itemi - 1
			if self.itemi < 1 then
				self.itemi = self.itemLength
			end

			self:checkItem(-1)
		elseif key == "rbutton" then
			self.itemi = self.itemi - 1
			if self.itemi > self.itemLength then
				self.itemi = 1
			end

			self:checkItem(1)
		elseif key == "x" then
			if self:getItemCount(self:getCurrentItem(true)) > 0 then
				self:use(self:getCurrentItem(true), false)
			end
		end
	end
end

function inventory:use(name)
	if name == "water" or name == "autopotion" then
		if not objects["player"][1]:hasLowHealth() then
			return
		end
		objects["player"][1]:addLife(2)
		healthPickup:play()
	elseif name == "rope" then
		if not tiled:getMapName():find("boss") then
			gameFadeOut = true
			gameInit(saveManager:getSaveData().currentMap)
		else
			gameNewDialog("turtle", "I can't use this in a boss fight!")
		end
	else
		return
	end
	gameNewDialog(nil, "Used " .. name .. "!")
	self:addItem(name, -1)
end
