item = class("item")

function item:initialize(filename, sold)
	for k, v in pairs(SHOP_ITEMS[filename]) do
		self[k] = v
	end

	self.sold = sold
	self.itemname = filename

	if self.func then
		self.func(self, state:get("player"), true)
	end
end

function item:purchase()
	local player = state:get("player")

	if not self.sold then
		if self:isAffordable() then
			if self.itemname == "fish" then
				if player.health == player.maxHealth then
					player:talk("My health is already full!")
					return
				end
			end
			self.func(self, player, false)
			player.money = player.money - self.cost
			self.sold = true
		end
	end
end

function item:isAffordable()
	local player = state:get("player")

	return player.money >= self.cost
end