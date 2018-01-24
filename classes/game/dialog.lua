dialog = class("dialog")

local dialogImage = love.graphics.newImage("graphics/game/dialogs.png")
local dialogQuads = {}
for i = 1, 4 do
	dialogQuads[i] = love.graphics.newQuad((i - 1) * 18, 0, 18, 14, dialogImage:getWidth(), dialogImage:getHeight())
end

local dialogSound = love.audio.newSource("audio/dialog.ogg", "static")

function dialog:initialize(speaker, text, autoTimeout)
	self.timer = 0
	self.line = 1

	self.x = 2
	self.y = 208
	
	self.width = 396
	self.height = 30

	self.speaker = self:getSpeaker(speaker)

	self.offset = 4
	if self.speaker then
		self.offset = 30
	end

	self.text = self:align(text, state:get("map").offset)
	self.i = 1

	self.renderNext = true
	self.lifeTime = 0

	self.printedText = ""
	self.autoTimeout = autoTimeout or false

	self.quadi = 1
	self.pauseTimer = 0
end

function dialog:update(dt)
	if self.timer < 0.02 then
		self.timer = self.timer + dt
	else
		if self.i <= #self.text then
			if not self.pause then
				local char = self.text:sub(self.i, self.i)

				self.printedText = self.printedText .. char
				
				self.i = math.min(self.i + 1, #self.text)
				
				self.timer = 0

				if self.i % 2 == 0 then
					dialogSound:play()
				end
			else
				if self.pause then
					self.pauseTimer = self.pauseTimer + 8 * dt
					self.quadi = math.floor(self.pauseTimer % #selectVerticalQuads) + 1

					if self.autoTimeout then
						self:clear()
					end
				end
			end
		end
	end

	if not self.renderNext then
		self.lifeTime = self.lifeTime + dt
		if self.lifeTime > 1 then
			self.remove = true
		end
	end
end

function dialog:draw(offset)
	love.graphics.push()
	love.graphics.translate((offset or 0), 0)

	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.rectangle("fill", self.x, self.y, self.width - (offset * 2), self.height)

	love.graphics.setColor(255, 255, 255, 255)

	if self.speaker then
		love.graphics.draw(dialogImage, dialogQuads[self.speaker], self.x + 5, self.y + (self.height - 14) / 2)
	end

	self:print(self.printedText, self.x + self.offset, self.y)

	if self.pause and self.renderNext then
		love.graphics.draw(selectVerticalImage, selectVerticalQuads[self.quadi], self.x + (self.width - (offset * 2) - 10), self.y + (self.height - 5) + math.sin(love.timer.getTime() * 4))
	end

	love.graphics.pop()
end

function dialog:keypressed(key)
	if self.autoTimeout then
		return
	end

	if key == "a" then
		if self.pause then	
			self:clear()
		end
	end
end

function dialog:clear()
	if self.i == #self.text then
		self.renderNext = false
	else
		self.printedText = ""
		self.timer = 0
		self.pauseTimer = 0
		self.quadi = 1
	end
	self.pause = false
end

function dialog:getSpeaker(name)
	local speaker = 1

	if name == "phoenix" then
		speaker = 2
	elseif name == "hermit" then
		speaker = 3
	elseif name == "unknown" then
		speaker = 4
	elseif name == nil then
		return nil
	end

	return speaker
end

function dialog:print(text, x, y)
	local startx = x

	for i = 1, #text do
		if text:sub(i, i) == "\n" then
			startx = x - i * 8
			y = y + 16
		elseif text:sub(i, i) == "~" then
			if not self.autoTimeout then
				self.pause = true
			else
				self:clear()
			end
		else
			love.graphics.print(text:sub(i, i), startx + (i - 1) * 8, y)
		end
	end
end

function dialog:align(text, offset)
	local newLimit = self.offset
	if offset > 0 then
		newLimit = (offset * 2) + self.offset
	end

	local limit = (self.width - newLimit) --limited between where text starts to render and end width of dialog box
	local size = 0 --our sentence size atm
	local ret = ""

	for word in text:gmatch("%S+% ?") do --match words n spaces
		size = size + gameFont:getWidth(word) --add to the size
		if size >= limit then --rip
			if not self.newLine then --make a newline happen (doesn't render, just tells it to 'newline' it)
				word = "\n" .. word --put a newline before the word that goes offscreen (see above)

				self.newLine = true
			else
				word = "~" .. word --tell dialog to 'stop' updating until jump is pressed

				self.newLine = false --allow newlines again
			end
			size = gameFont:getWidth(word)
		end
		ret = ret .. word
	end
	
	return ret .. "~"
end