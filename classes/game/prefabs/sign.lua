sign = class("sign")

local signImage = love.graphics.newImage("graphics/game/prefabs/sign.png")

function sign:initialize(layer, x, y, properties)
	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.active = true
	self.static = true

	self.used = false
	
	self.useRectangle = userectangle:new(self.x, self.y, self.width, self.height, function(player)
		if not self.used then
			player.freeze = true

			self.dialog = dialog:new(nil, properties.text or "!", true)
			table.insert(state:get("dialogs"), self.dialog)
			self.used = true
		end
	end)

	table.insert(layer, self)
end

function sign:update(dt)
	self.useRectangle:update(dt)
	if not self.dialog then
		if self.used then
			state:get("player").freeze = false
			self.used = false
		end
	else
		if self.dialog.remove then
			self.dialog = nil
		end
	end
end

function sign:draw()
	self.useRectangle:draw()
	love.graphics.draw(signImage, self.x, self.y)
end