userectangle = class("userectangle")

function userectangle:init(x, y, width, height, ...)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	self.timer = 0
	self.quadi = 1

	self.player = nil
	self.render = false

	local args = {...}
	self.func = args[1] or function() end
	self.invisible = args[2] or false
	self.once = args[3] or false
	self.funcArgs = args[4]
end

function userectangle:update(dt)
	local ret = checkrectangle(self.x + 4, self.y, self.width - 8, self.height, {"player"}, self)

	self.render = #ret > 0

	if self.render then
		self.player = ret[1][2]

		if self.func then
			if self.player.useKey then
				self.func(self.funcArgs)
				self.remove = self.once
			end
		end
	else
		self.player = nil
	end

	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #selectionVerQuads) + 1
end

function userectangle:draw()
	if eventSystem then
		if eventSystem:isRunning() then
			return
		end
	end

	if not self.render or self.invisible then
		return
	end

	love.graphics.setColor(0, 0, 0)
	love.graphics.draw(selectionVerImage, selectionVerQuads[self.quadi], (self.x + (self.width / 2)) - 6, (self.y - 19) + math.sin(love.timer.getTime() * 4))

	love.graphics.setColor(255, 0, 0)
	love.graphics.draw(selectionVerImage, selectionVerQuads[self.quadi], (self.x + (self.width / 2)) - 5, (self.y - 18) + math.sin(love.timer.getTime() * 4))

	love.graphics.setColor(255, 255, 255)
end

function userectangle:setPosition(x, y)
	self.x = x
	self.y = y
end