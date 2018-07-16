userectangle = class("userectangle")

function userectangle:initialize(x, y, width, height, ...)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	self.timer = 0
	self.quadi = 1

	self.render = false

	local args = {...}
	self.func = args[1] or function() 
		print("default func")
	end
	
	self.invisible = args[2] or false
	self.once = args[3] or false
	self.funcArgs = args[4] or {}
	
	self.condition = args[5] or function() 
		print("default cond") 
		return true 
	end
end

function userectangle:update(dt)
	local ret = checkrectangle(self.x, self.y, self.width, self.height, {"player"})

	self.render = #ret > 0

	if self.render then
		local player = ret[1]

		if self.func then
			if player.useKey then
				if self.condition(player) then
					self.func(player, self.funcArgs)
					self.remove = self.once
				end
				player:use(false)
			end
		end
	end

	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #selectVerticalQuads) + 1
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

	love.graphics.draw(selectVerticalImage, selectVerticalQuads[self.quadi], (self.x + (self.width / 2)) - 5, (self.y - 18) + math.sin(love.timer.getTime() * 4))
end

function userectangle:setPosition(x, y)
	self.x = x
	self.y = y
end