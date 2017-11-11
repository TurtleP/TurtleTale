item = class("item")

function item:init(filename, sold)
	for k, v in pairs(SHOP_ITEMS[filename]) do
		self[k] = v
	end

	self.sold = sold
	self.itemname = filename

	if self.func then
		self.func(self, objects["player"][1], true)
	end
end

function item:isSold()
	return self.sold
end

function item:getName()
	return self.name
end

function item:canBuy()
	local ret, name = true, self.name:lower()
	
	if name == "fish" then
		if not objects["player"][1]:hasLowHealth() then
			return false
		end
	end

	return ret
end

function item:purchase()
	if not self:canBuy() and self.name:lower() == "fish" then
		gameNewDialog("turtle", "I can't buy this. I already have full health!")
		return
	end

	if self.func then
		self.func(self, objects["player"][1])
	end

	if not self.reuse then
		self.sold = true
	end

	purchaseSound:play()
	SHOP_DATA[tiled:getMapName()][self.itemname] = true

	for k, v in ipairs(ITEM_NAMES) do
		if self.itemname == v then
			objects["player"][1].inventory:addItem(self.itemname)
		end
	end
end

function item:getDescription()
	return self.description
end

function item:getCost()
	return self.cost
end
