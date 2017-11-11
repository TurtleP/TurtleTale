
function love.errhand(error)
	error = error:gsub("^(./)", "")

	love.audio.stop()

	loadFont()

	love.graphics.setFont(gameFont)

	local err = {}

	local function wrapText(text, x, len)
		local width = 0
		local ret = ""

		for word in text:gmatch("%S+% ?") do
			width = width + gameFont:getWidth(word)
			if x + width >= len then
				word = "\n" .. word 
				width = 0
			end

			ret = ret .. word
		end

		return ret
	end

	local function printText(text, x, y, len)
		local originX, originY, newCount = x, y, 0
		
		for i = 1, #text do
			if text:sub(i, i) == "\n" then
				y = y + 12
				originX = x - i * 8
			end

			love.graphics.print(text:sub(i, i), originX + (i - 1) * 8, y)
		end
	end

	table.insert(err, "An error has occurred:")
	table.insert(err, "\n" .. wrapText(error, 2, 365) .. "\n")

	local OS = love.system.getOS()
	if love.system.getOS() == "Horizon" then
		OS = OS .. " (Nintendo 3DS)"
	end

	local major, minor, revision, codename = love.getVersion()
	local batteryState, batteryPercent, batterySeconds = love.system.getPowerInfo()
	local graphicsInfo = {love.graphics.getRendererInfo()}

	if batteryState == "nobattery" then
		batteryState, batteryPercent = "UNKNOWN", "UNKNOWN"
	else
		if batteryState == "battery" then
			batteryState = "Discharging"
		else
			batteryState = "Charging"
		end
	end

	local debugInfo = 
	{
		{"General", { {"Game Version", (version or "UNKNOWN")}, {"LOVE Version", (major .. "." .. minor .. "." .. revision) or "UNKNOWN"} }},
		{"\nDevice", { {"OS", OS}, {"Model", love.system.getModel()}, {"Battery", batteryState .. ", " .. batteryPercent .. "%"} }}
	}

	if graphicsInfo[4] then
		table.insert(debugInfo[2][2], {"Graphics", graphicsInfo[4]})
	end

	local message = "A log of this error has been saved."
	if mobileMode then
		table.remove(debugInfo[2][2], 2)
		if OS == "iOS" then
			message = "Take a screenshot of this error."
		end
	end

	for k, v in ipairs(debugInfo) do
		local header, body = v[1], v[2]
		table.insert(err, header)

		for i = 1, #v[2] do
			table.insert(err, "  " .. v[2][i][1] .. ": " .. v[2][i][2])
		end
	end

	table.insert(err, "\n" .. message)
	table.insert(err, "Attach it to an issue here https://goo.gl/uhW6zH")
	table.insert(err, "\nPress 'Start' to quit.")

	local p = table.concat(err, "\n")

	print(p)

	if OS ~= "iOS" then
		love.filesystem.createDirectory("errors")

		local errors = #love.filesystem.getDirectoryItems("errors")

		love.filesystem.write("errors/error_" .. (errors + 1) .. ".txt", p)
	end
	
	local key = "escape"
	if not _EMULATEHOMEBREW and not mobileMode then
		key = "start"
	end

	local function draw()
		love.graphics.setScreen("top")

		love.graphics.setColor(0, 0, 0, 200)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

		love.graphics.setColor(255, 255, 255, 255)
		printText(p, 2, 0, 365)

		love.graphics.present()
	end
	
	draw()
	
	if Horizon.RUNNING then
		local e, a, b, c
		while true do
			e, a, b, c = love.event.wait()

			love.timer.sleep(0.001)

			if e == "quit" then
				return
			end

			if e == "keypressed" and a == "escape" then
				break
			end
		end
		love.event.quit()
	else
		while true do
			love.scan()

			love.timer.sleep(0.001)

			if love.keyboard.isDown("start") then
				break
			end
		end
		love.quit()
	end
end