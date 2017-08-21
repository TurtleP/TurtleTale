dialog = class("dialog")

local dialogImage = love.graphics.newImage("graphics/dialogs.png")
local dialogQuads = {}
for i = 1, 4 do
	dialogQuads[i] = love.graphics.newQuad((i - 1) * 18, 0, 18, 14, dialogImage:getWidth(), dialogImage:getHeight())
end

function dialog:init(speaker, text)
	self.timer = 0
	self.i = 1

	self.string = ""
	self.renderNext = false

	self.x = 1
	self.y = 212
	self.width = 398
	self.height = 25

	self.text = self:align(text)
	self.pause = false

	self.speaker = dialogQuads[self:getSpeaker(speaker)]

	self.life = 0
end

function dialog:update(dt)
	if self.i <= #self.text then
		if #self.string < #self.text and not self.pause then
			if self.timer < 0.02 then
				self.timer = self.timer + dt
			else
				self.string = self.string .. self.text:sub(self.i, self.i)

				self.i = self.i + 1
				dialogSound:play()
				self.timer = 0
			end
		else
			self.renderNext = true

			if love.keyboard.isDown("a") then
				self.pause = false
				self.timer = 0
				self.string = ""
				self.renderNext = false
			end
		end
	else
		self.life = self.life + dt
		if self.life > 1 then
			self.remove = true
		end
	end
end

function dialog:draw()
	love.graphics.setScreen("top")

	love.graphics.setFont(smallFont)

	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	
	love.graphics.setColor(255, 255, 255, 255)
	self:print(self.string, self.x + 28, self.y)

	love.graphics.draw(dialogImage, self.speaker, self.x + 13 - 9, self.y + (self.height / 2) - 7)

	if self.renderNext then
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.draw(selectionVerImage, selectionVerQuads[1], (self.x + self.width) - 10, (self.y + self.height) - 5 + math.sin(love.timer.getTime() * 4))
	end

	love.graphics.setColor(255, 255, 255, 255)

	--love.graphics.setScissor()
end

function dialog:print(text, x, y)
	local startx = x

	for i = 1, #text do
		if text:sub(i, i) == "\n" then
			startx = x - i * 8
			y = y + 10
		elseif text:sub(i, i) == "~" then
			self.pause = true
		else
			love.graphics.print(text:sub(i, i), startx + (i - 1) * 8, y)
		end
	end
end

function dialog:align(text)
	local limit = self.width - 28 --limited between where text starts to render and end width of dialog box
	local size = 0 --our sentence size atm
	local ret = ""

	for word in text:gmatch("%S+% ?") do --match words n spaces
		size = size + smallFont:getWidth(word) --add to the size
		if size >= limit then --rip
			if not self.newLine then --make a newline happen (doesn't render, just tells it to 'newline' it)
				word = "\n" .. word --put a newline before the word that goes offscreen (see above)

				self.newLine = true
			else
				word = word .. "~" --tell dialog to 'stop' updating until jump is pressed

				self.newLine = false --allow newlines again
			end
			size = smallFont:getWidth(word)
		end
		ret = ret .. word
	end
	
	return ret
end

function dialog:getSpeaker(i)
	if type(i) == "number" then
		return i
	elseif type(i) == "string" then
		local ret = 4
		if i == "turtle" then
			ret = 1
		elseif i == "phoenix" then
			ret = 2
		elseif i == "hermit" then
			ret = 3
		end
		return ret
	end
	return 4
end