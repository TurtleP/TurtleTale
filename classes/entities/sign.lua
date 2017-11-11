sign = class("sign")

local signImage = love.graphics.newImage("graphics/game/sign.png")

function sign:init(x, y, properties)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	local text = "!"
	if properties.text then
		text = properties.text
	end

	self.activated = false
	self.use = userectangle:new(self.x, self.y, 16, 16, function()
		if not self.activated then
			gameNewDialog(nil, text)
			self.activated = true
		end
	end)

	self.delay = 3
end

function sign:update(dt)
	self.use:update(dt)

	if self.use.render then
		if #dialogs ~= 0 then
			objects["player"][1]:freeze(true)
		else
			objects["player"][1].frozen = false
			self.activated = false
		end
	end
end

function sign:draw()
	self.use:draw()

	love.graphics.draw(signImage, self.x, self.y)
end