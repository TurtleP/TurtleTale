trigger = class("trigger")

function trigger:init(x, y, width, height, property)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	if property.map then
		self.map = property.map:split(";")
	end

	self.category = 4

	self.triggered = false
end

function trigger:update(dt)
	local ret = checkrectangle(self.x, self.y, self.width, self.height, {"player"}, self)

	if not self.map then
		return
	else
		if #ret == 0 then
			if self.triggered then
				local map = self.map[1]
			
				SPAWN_X, SPAWN_Y = tonumber(self.map[2]), tonumber(self.map[3])
						
				self.triggered = false

				gameInit(map)
			end
			return
		else
			local player = ret[1][2]
			
			player.speedx = 48 * player.scale
			if player.speedx < 0 then
				player.leftKey = true
			elseif player.speedx > 0 then
				player.rightKey = true
			end
			
			player.teleport = true
			self.triggered = true
		end
	end
end