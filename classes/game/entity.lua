entity = class("entity", object)

function entity:initialize(layer, x, y, width, height)
	object.initialize(self, x, y, width, height)

	self.category = 0
	self.mask = { false }

	self.state = "idle"

	if layer then
		table.insert(layer, self)
	end
end

function entity:talk(text, autoscroll)
	local dialogs = state:get("dialogs")
	
	self.dialog = dialog:new(tostring(self), text, autoscroll)
	table.insert(dialogs, self.dialog)
end

function entity:update(dt)

end

function entity:draw()

end

function entity:die(reason)
	local whois = tostring(self)

	if whois ~= "player" then
		if not object.die(self, reason) then --died for a bad reason I guess, usually a pit
			return --don't let it do anything else, except be removed!
		end
	end


	local smokeFrame = 0
	if whois == "bat" or self.speed.y ~= 0 then
		smokeFrame = 5
	end

	smoke:new(self.x + (self.width - 24) / 2, self.y + (self.height - 24), smokeFrame)

	if not BOSSES[whois] and whois ~= "crate" then
		self:dropCollectibles()
	end
	
	if whois ~= "player" then
		self.remove = true
	end
end

function entity:dropCollectibles()
	local whois = tostring(self)

	if whois == "player" then
		return
	end

	local player = state:get("player")
	if player.health < player.maxHealth then
		if math.random() < 0.3 then
			if not self:insideTile() then --died inside a tile
				health:new(self.x + (self.width - 13) / 2, self.y + (self.height - 8) / 2)
			else
				player:addHealth(1)
			end
		end
	end

	local random, cost = math.random(), 1
	if random < .1 then
		cost = 5
	elseif random < .05 then
		cost = 10
	end

	if not self:insideTile() then
		shell:new(self.x + (self.width - 4) / 2, self.y + (self.height - 5) / 2)
	else
		player:addMoney(cost)
	end
end

function entity:insideTile()
	return #checkrectangle(self.x, self.y, self.width, self.height, {"tile"}) > 0
end

function entity:setState(state)
	if self.state ~= state then
		self.quadi = 1
		self.timer = 0
		self.state = state
	end
end

function entity:setMask(id, value)
	self.mask[id] = value
end

function entity:setGravity(gravity)
	self.gravity = gravity
end

function entity:globalCollide(name, data)
	if name == "tile" then
		if data.spikes then
			self:die()
		end
	end
end