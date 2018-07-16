block = class("block", object)

function block:initialize(layer, x, y, width, height, properties)
	object.initialize(self, x, y, width, height)

	self.category = 7
	self.open = false

	for k, v in pairs(properties) do
		if type(k) == "string" then
			self[k] = v
		end
	end

	if self.open then
		self.y = self.y - self.height
	end

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

function block:fix()
	self.y = self.origin.y - self.height
end

function block:draw()
	local offset, camera = state:get("map").offset, math.floor(state:get("camera").x)
	if offset == -camera then
		offset = 0
	end

	love.graphics.setScissor(self.x - (offset + camera), self.origin.y, self.width, self.height)
	
	for y = 1, 2 do
		love.graphics.draw(gameTilesImage, gameTilesQuads[225], self.x, self.y + (y - 1) * 16)
	end

	love.graphics.setScissor()
end

function block:use(t)
	if t == "on" then
		self.open = true
	elseif t == "off" then
		self.open = false
		self.passive = false
	end
	self.power = t
end