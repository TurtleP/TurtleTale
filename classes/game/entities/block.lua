block = class("block", object)

function block:initialize(layer, x, y, width, height)
	object.initialize(self, x, y, width, height)

	self.category = 7
	self.open = false

	self.originY = y

	table.insert(layer, self)
end

function block:update(dt)
	if self.power then
		if self.open then
			self.y = math.max(self.y - 64 * dt, self.origin.y - self.height)
		elseif not self.open then
			self.y = math.min(self.y + 64 * dt, self.origin.y)
		end
	end
end

function block:draw()
	local offset, camera = state:get("map").offset, math.floor(state:get("camera").x)
	if offset == -camera then
		offset = 0
	end

	love.graphics.setScissor(self.x - (offset + camera), self.originY, self.width, self.height)
	
	for y = 1, 2 do
		love.graphics.draw(gameTilesImage, gameTilesQuads[225], self.x, self.y + (y - 1) * 16)
	end

	love.graphics.setScissor()
end

function block:use(t)
	print(t)
	if t == "on" then
		self.open = true
	elseif t == "off" then
		self.open = false
	end
	self.power = t
end