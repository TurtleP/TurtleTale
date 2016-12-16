pausemenu = class("pausemenu")

function pausemenu:init()
	self.options = 
	{
		{"Continue", 
			function() 
				paused = false 
			end
		},
		{"Save and Continue", 
			function() 
				saveManager:save(saveManager:getCurrentSave(), {os.date("%m.%d.%Y"), objects["player"][1]:getHealth(), objects["player"][1]:getMaxHealth(), saveManager:getTime()}) --last save, current HP, time played 
				
				paused = false 
			end
		},
		{"Save and Quit",
			function()
				--saveGame()

				util.changeState("title")
			end
		},
	}

	self.currentOption = 1
end

function pausemenu:draw()
	love.graphics.setScreen("top")

	local x, y, w, h = util.getWidth() / 2 - 80, util.getHeight() / 2 - 36, 160, 72

	love.graphics.setColor(0, 0, 0, 200)

	love.graphics.rectangle("fill", x, y, w, h)

	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.print("Paused", x + (w / 2) - smallFont:getWidth("Paused") / 2, y + 8)

	for k = 1, #self.options do
		local v, addLeft, addRight = self.options[k], "", ""

		if self.currentOption == k then
			addLeft, addRight = "[", "]"
		end
		love.graphics.print(addLeft .. v[1] .. addRight, x + (w / 2) - smallFont:getWidth(addLeft .. v[1] .. addRight) / 2, (y + 24) + (k - 1) * 16)
	end
end

function pausemenu:keypressed(key)
	if key == controls["down"] then
		if self.currentOption < #self.options then
			self.currentOption = self.currentOption + 1

			self.sineTimer = 0
		end
	elseif key == controls["up"] then
		if self.currentOption > 1 then
			self.currentOption = self.currentOption - 1

			self.sineTimer = 0
		end
	elseif key == "a" then
		self.options[self.currentOption][2]()
	end
end
