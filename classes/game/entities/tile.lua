tile = class("tile", object)

function tile:initialize(layer, x, y, width, height, properties)
	object.initialize(self, x, y, width, height)

	self.category = 1

	for k, v in pairs(properties) do
		if type(k) == "string" then
			self[k] = v
		end
	end

	self.active = false
	self.static = true

	if self.breakable then
		self.active = true
	elseif self.ladder then
		self.category = 10
		self.static = false
	elseif self.collapse then
		self.timer = 0
		self.quadi = 1
		self.active = true
	end

	self.layer = layer
	table.insert(layer, self)
end

function tile:update(dt)
	if self.breaking then
		if self.quadi < #crackQuads then
			self.timer = self.timer + 3 * dt
			self.quadi = math.floor(self.timer % #crackQuads) + 1
		else
			particle:new(self.layer, self.x, self.y, vector(-40, -64), {68, 100, 124})
			particle:new(self.layer, self.x + self.width, self.y, vector(40, -64),  {68, 100, 124})
			self.remove = true
		end
	end
end

function tile:draw()
	if self.id then
		love.graphics.draw(gameTilesImage, gameTilesQuads[self.id], self.x, self.y)
	end
	
	if self.collapse then
		love.graphics.draw(crackImage, crackQuads[self.quadi], self.x, self.y)
	end
end

function tile:destroy()
	self.breaking = true
end