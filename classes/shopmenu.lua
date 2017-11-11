shopmenu = class("shopmenu")

local purchaseVoicelines = 
{
	"Thank you for the purchase, Mr. Turtle.",
	"Hmm.. Looks like that'll come in hand for ya"
}

local declinedVoicelines =
{
	"Sorry pal, this item's too expensive for you.",
	"No wares, no purchase. Store policy, alright?"
}

local stopShopVoicelines =
{
	"Good day, sir, and good luck!",
	"Come back again!"
}

function shopmenu:init(inventory)
	self.width = 160
	self.height = 116

	self.x = 120
	self.y = 28

	self.inventory = {}

	self.fade = 0
	self.selection = 1

	self.timer = 0
	self.quadi = 1

	for i, v in pairs(inventory) do
		table.insert(self.inventory, item:new(i, v))
	end

	self.width = 160
	self.x = (320 - self.width) / 2
end

function shopmenu:update(dt)
	if SHOP_OPEN then
		self.fade = math.min(self.fade + dt / 0.8, 1)
	else
		self.fade = math.max(self.fade - dt / 0.8, 0)
	end

	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #selectionQuads) + 1
end

function shopmenu:draw()
	love.graphics.setColor(0, 0, 0, 128 * self.fade)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	for i = 1, #self.inventory do
		if self.selection == i then
			love.graphics.setColor(255, 255, 255, 255 * self.fade)
			love.graphics.draw(selectionImage, selectionQuads[self.quadi], self.x + 4 + math.cos(love.timer.getTime() * 4), self.y + 8 + (i - 1) * 18 + 2)
		end
		
		if (self.inventory[i]:isSold() or objects["player"][1]:getMoney() < self.inventory[i]:getCost()) or not self.inventory[i]:canBuy() then
			love.graphics.setColor(200, 200, 200, 255 * self.fade)
		else
			love.graphics.setColor(255, 255, 255, 255 * self.fade)
		end
		love.graphics.print(self.inventory[i]:getName(), self.x + 14, self.y + 8 + (i - 1) * 18)
		love.graphics.print(self.inventory[i]:getCost(), self.x + self.width - gameFont:getWidth(self.inventory[i]:getCost()) - 14, self.y + 8 + (i - 1) * 18)
	end

	love.graphics.setColor(255, 255, 255, 255)
end

function shopmenu:keypressed(key)
	if eventSystem and eventSystem:isRunning() then
		return
	end

	if key == "x" then
		gameNewDialog("hermit", self.inventory[self.selection]:getDescription(), true)
	end

	if key == controls["down"] then
		self.selection = math.min(self.selection + 1, #self.inventory)
	elseif key == controls["up"] then
		self.selection = math.max(self.selection - 1, 1)
	end

	if key == "a" then
		if not self.inventory[self.selection]:isSold() then --not sold yet
			if objects["player"][1]:getMoney() >= self.inventory[self.selection]:getCost() then --enough money
				objects["player"][1]:addMoney(-self.inventory[self.selection]:getCost())
				gameNewDialog("hermit", purchaseVoicelines[math.random(#purchaseVoicelines)])

				self.inventory[self.selection]:purchase()
			else
				gameNewDialog("hermit", declinedVoicelines[math.random(#declinedVoicelines)])
			end
		end
	end

	if key == "b" then
		if SHOP_OPEN then
			gameNewDialog("hermit", stopShopVoicelines[math.random(#stopShopVoicelines)])
			SHOP_OPEN = false
		end
	end
end