dialog = class("dialog")

local dialogImage = love.graphics.newImage("graphics/dialogs.png")
local dialogQuads = {}
for i = 1, 4 do
	dialogQuads[i] = love.graphics.newQuad((i - 1) * 18, 0, 18, 14, dialogImage:getWidth(), dialogImage:getHeight())
end

function dialog:init(speaker, text, continue, hasPrompt)
	self.timer = 0
	self.i = 1

	self.string = ""
	self.renderNext = false

	local x, width = 1, 398
	if tiled:getWidth("top") < 25 and state ~= "title" then
		x, width = 41, (tiled:getWidth("top") * 16) - 2
	end

	self.x = x
	self.y = 212
	
	self.width = width
	self.height = 27

	local talker, offset = nil, 4
	if speaker ~= nil then
		talker, offset = dialogQuads[self:getSpeaker(speaker)], 28
	end
	self.offset = offset

	self.speaker = talker
	self.continue = continue or false

	self.text = self:align(text)
	self.pause = false

	if hasPrompt then
		self.prompt = prompt:new(self.x + self.width, self.y, {"Yes", "No"}, hasPrompt)
	end

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

				if self.i % 2 == 0 then
					dialogSound:play()
				end

				self.timer = 0
			end
		else
			self.renderNext = true

			if love.keyboard.isDown("a") or self.continue then
				self:reset()
			end
		end
	else
		if self.prompt then
			self.prompt:update(dt)
			return
		end

		self.life = self.life + dt
		if self.life > 1 then
			self.remove = true
		end
	end
end

function dialog:reset()
	self.pause = false
	self.timer = 0
	self.string = ""
	self.renderNext = false
end

function dialog:draw()
	love.graphics.setScreen("top")

	love.graphics.setFont(gameFont)

	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

	if self.prompt then
		self.prompt:draw()
	end

	love.graphics.setColor(255, 255, 255, 255)

	self:print(self.string, self.x + self.offset, self.y)

	if self.speaker then
		love.graphics.draw(dialogImage, self.speaker, self.x + 13 - 9, self.y + (self.height / 2) - 7)
	end

	if self.renderNext then
		love.graphics.setColor(255, 0, 0)
		love.graphics.draw(selectionVerImage, selectionVerQuads[1], (self.x + self.width) - 10, (self.y + self.height) - 10 + math.sin(love.timer.getTime() * 4))
	end

	love.graphics.setColor(255, 255, 255, 255)

	--love.graphics.setScissor()
end

function dialog:print(text, x, y)
	local startx = x

	for i = 1, #text do
		if text:sub(i, i) == "\n" then
			startx = x - i * 8
			y = y + 12
		elseif text:sub(i, i) == "~" then
			self.pause = true
		else
			love.graphics.print(text:sub(i, i), startx + (i - 1) * 8, y)
		end
	end
end

function dialog:align(text)
	local limit = self.width - self.offset --limited between where text starts to render and end width of dialog box
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

----
prompt = class("prompt")

function prompt:init(x, y, items, func)
	self.x = x - 40
	self.y = y - 28

	self.width = 40
	self.height = 28

	self.items = items
	self.funcs = func

	self.timer = 0
	self.quadi = 1

	self.selection = 1
end

function prompt:update(dt)
	self.timer = self.timer + 8 * dt
	self.quadi = math.floor(self.timer % #selectionQuads) + 1
end

function prompt:draw()
	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

	for i = 1, #self.items do
		if i ~= self.selection then
			love.graphics.setColor(128, 128, 128)
		else
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(selectionImage, selectionQuads[self.quadi], self.x + 4 + math.cos(love.timer.getTime() * 4), self.y + (i - 1) * 14 + 2)
		end
		love.graphics.print(self.items[i], self.x + self.width - gameFont:getWidth(self.items[i]) - 4, self.y + (i - 1) * 14)
	end
end

function prompt:keypressed(key)
	if key == controls["down"] then
		self.selection = math.min(self.selection + 1, #self.items)
	elseif key == controls["up"] then
		self.selection = math.max(self.selection - 1, 1)
	end

	if key == "a" then
		self.funcs[self.selection]()
	end
end