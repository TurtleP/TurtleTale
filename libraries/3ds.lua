if love.system.getOS() ~= "3ds" then
	_SCREEN = "top"
	_MODEL = 1
	
	models = {"PC", "3DS", "3DSXL"}
	function love.system.getModel()
		return models[_MODEL]
	end

	function love.system.setModel(s)
		scale = math.max(s - 1, 1)
		_MODEL = s
		
		if love.system.getModel() ~= "PC" then
			love.window.setMode(400 * scale, 480 * scale, {vsync = true})
		else
			love.window.setMode(400 * scale, 240 * scale, {vsync = true})
		end

		love.window.setTitle(love.filesystem.getIdentity() .. " :: " .. love.system.getModel())
	end

	love.system.setModel(1)

	function love.graphics.setScreen(screen)
		assert(type(screen) == "string", "String expected, got " .. type(screen))

		_SCREEN = screen

		--[[if screen == "top" then
			love.graphics.setScissor(0, -(mapScrollY or 0 * scale), 400 * scale, 240 * scale)
		elseif screen == "bottom" then
			love.graphics.setScissor(40 * scale, (240 * scale) - (mapScrollY or 0 * scale), 320 * scale, 240 * scale)
		end]]
	end

	function love.graphics.getWidth()
		if love.graphics.getScreen() == "bottom" then
			return 320
		end
		return 400
	end

	local oldSetColor = love.graphics.setColor
	function love.graphics.setColor(r, g, b, a)
		if type(r) == "table" then
			oldSetColor(unpack(r))
		else
			oldSetColor(r, g, b, a)
		end
	end

	function love.graphics.getHeight()
		return 240
	end

	function love.graphics.getScreen()
		return _SCREEN
	end

	local oldclear = love.graphics.clear
	function love.graphics.clear(r, g, b, a)
		--love.graphics.setScissor()

		oldclear(r, g, b, a)
	end

	local _KEYNAMES =
	{
		"a", "b", "select", "start",
		"dright", "dleft", "dup", "ddown",
		"rbutton", "lbutton", "x", "y",
		"lzbutton", "rzbutton", "cstickright", 
		"cstickleft", "cstickup", "cstickdown",
		"cpadright", "cpadleft", "cpadup", "cpaddown"
	}

	BUTTONCONFIG =
	{
		["a"] = "z",
		["b"] = "x",
		["y"] = "c",
		["x"] = "v",
		["start"] = "return",
		["select"] = "rshift",
		["up"] = "up",
		["left"] = "left",
		["right"] = "right",
		["down"] = "down",
		["rbutton"] = "/",
		["lbutton"] = "rcontrol",
		["cpadright"] = "",
		["cpadleft"] = "",
		["cpadup"] = "",
		["cpaddown"] = "",
		["cstickleft"] = "",
		["cstickright"] ="",
		["cstickup"] = "",
		["cstickdown"] = ""
	}

	--[[if love.keypressed then
		local oldKeyPressed = love.keypressed
		function love.keypressed(key)
			for k = 1, #_KEYNAMES do
				if _CONFIG[_KEYNAMES[k] == key then
					oldKeyPressed(_KEYNAMES[k])
				end
			end
		end
	end

	if love.keyreleased then
		local oldKeyReleased = love.keyreleased
		function love.keyreleased(key)
			for k = 1, #_KEYNAMES do
				if _CONFIG[_KEYNAMES[k] == key then
					oldKeyReleased(_KEYNAMES[k])
				end
			end
		end
	end]]

	-- Clamps a number to within a certain range.
	function math.clamp(low, n, high) 
		return math.min(math.max(low, n), high) 
	end

	local oldMousePressed = love.mousepressed
	function love.mousepressed(x, y, button)
		x, y = math.clamp(0, x - 40, 320), math.clamp(0, y - 240, 240)

		if oldMousePressed then
			oldMousePressed(x, y, 1)
		end
	end

	local oldMouseReleased = love.mousereleased
	function love.mousereleased(x, y, button)
		x, y = math.clamp(0, x - 40, 320), math.clamp(0, y - 240, 240)

		if oldMouseReleased then
			oldMouseReleased(x, y, 1)
		end
	end
end

if love.system.getOS() == "3ds" or _EMULATEHOMEBREW then
	if not _EMULATEHOMEBREW then
		love.graphics.scale = function() end
		--math = { random = math.random, setRandomSeed = math.randomseed }
		love.graphics.setDefaultFilter = function() end
		love.audio.setVolume = function() end

		if not love.filesystem then
			love.filesystem = {}

			function love.filesystem.isFile(path)
				return io.open(path)
			end

			function love.filesystem.isDirectory(path)
				return love.filesystem.isFile(path):read(1) == 21
			end

			function love.filesystem.write(path, data)
				if path and data then
					local file = io.open(path, "w")

					if file then
						file:write(data)

						file:flush()

						file:close()
					else
						error("Could not create file!")
					end
				else
					error("Could not write file: " .. path .. "!")
				end
			end

			function love.filesystem.read(path)
				if path then
					local file = io.open(path, "r")

					if file then
						return file:read()
					else
						error("Could not read file, does not exist!")
					end
				else
					assert(type(path) == "string", "String expected, got " .. type(path))
				end
			end

			function love.filesystem.remove(path)
				if path then
					os.remove(path)
				end
			end
		end
	else
		love.graphics.set3D = function() end
		love.graphics.setDepth = function() end
		
		love.system.setModel(2)
		
		local olddraw = love.graphics.draw
		function love.graphics.draw(...)
			local args = {...}

			local image = args[1]
			local quad
			local x, y, r = 0, 0, 0
			local scalex, scaley = 1, 1

			if type(args[2]) == "userdata" then
				quad = args[2]
				x = args[3] or 0
				y = args[4] or 0
				scalex, scaley = args[6] or 1, args[7] or 1
			else
				x, y = args[2] or 0, args[3] or 0
				r = args[4] or 0
			end

			if love.graphics.getScreen() == "bottom" then
				x = x + 40
				y = y + 240
			end

			if not quad then
				if r then
					olddraw(image, x + image:getWidth() / 2, y + image:getHeight() / 2, r, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
				else
					olddraw(image, x, y,  0, scale, scale)
				end
			else
				olddraw(image, quad, x, y, args[5], scalex * scale, scaley * scale)
			end
		end

		local oldRectangle = love.graphics.rectangle
		function love.graphics.rectangle(mode, x, y, width, height)
			if love.graphics.getScreen() == "bottom" then
				x = x + 40
				y = y + 240
			end
			oldRectangle(mode, x, y, width, height)
		end

		local oldCircle = love.graphics.circle
		function love.graphics.circle(mode, x, y, r, segments)
			if love.graphics.getScreen() == "bottom" then
				x = x + 40
				y = y + 240
			end
			oldCircle(mode, x, y, r, segments)
		end

		local oldPrint = love.graphics.print
		function love.graphics.print(text, x, y, r, scalex, scaley, sx, sy)
			if love.graphics.getScreen() == "bottom" then
				x = x + 40
				y = y + 240
			end
			oldPrint(text, x, y, r, scalex, scaley, sx, sy)
		end
		
		if love.keypressed then
			local oldKey = love.keypressed

			function love.keypressed(key)
				for k, v in pairs(BUTTONCONFIG) do
					if key == v then
						oldKey(k)
						break
					end
					end
			end
		end

		if love.keyreleased then
			local oldKey = love.keyreleased

			function love.keyreleased(key)
				for k, v in pairs(BUTTONCONFIG) do
					if key == v then
						oldKey(k)
						break
					end
				end

				if key == "1" or key == "2" or key == "3" then
					love.system.setModel(tonumber(key))
				end
			end
		end
	end
end