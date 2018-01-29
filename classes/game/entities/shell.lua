shell = class("shell", object)

function shell:initialize(x, y, cost)
	object.initialize(self, x, y, 7, 6)

	local cost, quadi = 1, 1
	if cost == 5 then
		quadi = 2
	elseif cost == 10 then
		self.width = 6
		self.height = 10
		quadi = 3
	end

	self.category = 4

	self.mask = { true }

	self.gravity = 480
	self.quadi = quadi

	self.cost = cost

	local layers = state:get("layers")

	table.insert(layers[1], self)
end

function shell:draw()
	love.graphics.draw(moneyImage, moneyQuads[self.quadi], self.x, self.y)
end

function shell:collect(player)
	player:addMoney(self.cost)
	self:die()
end

function shell:downCollide(name, data)
	if name == "tile" then
		self.speed.y = -(self.speed.y * 0.3)
		return false
	end
end