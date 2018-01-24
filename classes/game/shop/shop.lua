local shop = class("shop")

function shop:initialize()
	self.data = {}
	
	self.fades = { ["false"] = 0.5, ["true"] = 1 }
	self.fade = self.fades[tostring(SHOP_OPEN)]
	self.timer = 1

	self.itemSpacing = 25
end

function shop:loadData(map)
	if not SHOP_DATA[map] then
		self.data = {}
		return
	end

	local data = SHOP_DATA[map]

	for k, v in pairs(data) do
		table.insert(self.data, item:new(k, v))
	end

	self.selection = 1
	self.selectTimer = 0
	self.quadi = 1
	self.rawData = data
end

function shop:update(dt)
	if SHOP_OPEN then
		self.fade = 1
	else
		self.fade = 0.5
	end
	self.timer = math.max(self.timer - dt, 0)

	self.fade = self.fades[tostring(SHOP_OPEN)]

	if self.selectTimer then
		self.selectTimer = self.selectTimer + 8 * dt
		self.quadi = math.floor(self.selectTimer % #selectHorizontalQuads) + 1
	end

	if not SHOP_OPEN and self.timer == 0 then
		state:get("player").freeze = false
	end
end

function shop:draw()
	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	
	local y = (SCREEN_HEIGHT - (#self.data * self.itemSpacing)) / 2

	for i = 1, #self.data do
		if self.data[i].sold and SHOP_OPEN then
			love.graphics.setColor(200, 200, 200, 255)
		end
		love.graphics.print(self.data[i].name, BOTSCREEN_WIDTH * 0.15, y + (i - 1) * self.itemSpacing)
		love.graphics.print(self.data[i].cost, BOTSCREEN_WIDTH * 0.75, y + (i - 1) * self.itemSpacing)
	end

	if SHOP_OPEN then
		love.graphics.draw(selectHorizontalImage, selectHorizontalQuads[self.quadi], BOTSCREEN_WIDTH * 0.10 + math.cos(love.timer.getTime() * 4) * 2, y + (self.selection - 1) * self.itemSpacing + 2)
	end

	love.graphics.setColor(255, 255, 255, 255)
end

function shop:keypressed(key)
	if key == "down" then
		self.selection = math.min(self.selection + 1, #self.data)
	elseif key == "up" then
		self.selection = math.max(self.selection - 1, 1)
	elseif key == "b" then
		SHOP_OPEN = false
	elseif key == "a" then
		if self.data[self.selection]:isAffordable() then
			self.data[self.selection]:purchase()
			self.rawData[self.data[self.selection].itemname] = true
		else
			state:call("addDialog", "hermit", "Sorry pal, you ain't got enough shells for this.")
		end
	elseif key == "x" then
		state:call("addDialog", "hermit", self.data[self.selection].description)
	end
end

return shop:new()