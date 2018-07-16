spawner = class("spawner")

function spawner:initialize(layer, x, y, properties)
	self.x = x
	self.y = y

	for k, v in pairs(properties) do
		if type(k) == "string" then
			self[k] = v
		end
	end

	self.active = true
	self.static = true

	self.data = self.type:split(";")
	self.delay = tonumber(self.data[1])

	self.objects = 0

	self.layer = layer
	table.insert(layer, self)
end

function spawner:update(dt)
	if self.waitForDespawn then
		if self.objects < 1 then
			crate:new(self.layer, self.x, self.y, {direction = self.direction})
			self.objects = self.objects + 1
		else
			if not state:call("findObject", "crate") then
				self.objects = 0
			end
		end
	else	
		-- TODO: handle that
	end
end