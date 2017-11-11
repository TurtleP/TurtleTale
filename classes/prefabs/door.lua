door = class("door", userectangle)

function door:init(x, y, properties, screen)
	userectangle.init(self, x, y, 16, 16)

	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.link = properties.link:split(";")
	
	self.render = false

	self.category = 4

	self.active = true
	self.static = true

	self.timer = 0
	self.quadi = 1

	self.screen = screen
	self.doTransition = false
	
	local active = true
	if properties.active ~= nil then
		active = properties.active
	end
	self.active = active
end

function door:update(dt)
	if not self.active then
		return
	end

	userectangle.update(self, dt)

	if not self.render then
		return
	else
		if self.player.useKey then
			if self.player.speedy == 0 then
				self.doTransition = true
			end
		end

		if self.doTransition then
			self.player:freeze()
			gameFadeOut = true

			if gameFade == 1 then
				SPAWN_X, SPAWN_Y = tonumber(self.link[2]), tonumber(self.link[3])
				gameInit(self.link[1])
			end
		end
	end
end

function door:draw()
	userectangle.draw(self)
end

function door:fix()
	self.active = true
end

function door:setActive(active)
	self.active = active
	table.insert(MAP_DATA[tiled:getMapName()], {self.x, self.y, true})
end