button = class("button", object)

function button:initialize(layer, x, y, properties)
	object.initialize(self, x, y, 3, 6)

	self.category = 8

	self.static = true

	self.links = {}
	if properties.link then
		local links = properties.link:split("-")

		for i = 1, #links do
			table.insert(self.links, links[i])
		end
	end

	for k, v in pairs(properties) do
		if type(k) == "string" and k ~= "link" then
			self[k] = v
		end
	end

	self.power = "off"

	if self.time then
		self.maxTime = self.time
	end

	table.insert(layer, self)
end

function button:update(dt)
	if self.power == "on" then
		self.time = self.time - dt
		if self.time < 0 then
			self:fire("off")
			self.time = self.maxTime
		end
	end
end

function button:fire(power)
	local layers = state:get("layers")

	for t = 1, #self.links do
		local item, x, y, data = unpack(self.links[t]:split(";"))
		x, y = tonumber(x), tonumber(y)
		
		local object = state:call("findObject", item, x, y)

		if object then
			object:use(power)
		end
	end

	self.power = power
end

function button:draw()
	love.graphics.rectangle("fill", self.x, self.y, 3, 6)
end

function button:use(player)
	if player.scale == -self.scale then
		if self.power ~= "on" then
			self:fire("on")
		end
	end
end