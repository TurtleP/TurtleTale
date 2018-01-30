local event = class("event")

function event:initialize()
	self.sleep = 0
	self.current = 1
	self.eventData = {}

	self.running = false

	self.shakeLoop = false
	self.shakeTimer = 0
end

function event:load(name, data)
	local pass = false
	for i, v in ipairs(data) do
		local command, args = v[1], v[2]

		if command == "levelequals" then
			if state:get("map").name == args then
				pass = true
			end
		elseif data.manual then
			pass = true
		end
	
		if pass then
			self.autoScroll = data.autoscroll or false
			self.name = name
			self.save = data.save or false
			self.running = true

			table.insert(self.eventData, {command = command, args = args})
		end
	end

end

function event:update(dt)
	if self.running then
		if #state:get("dialogs") > 0 then
			self.sleep = dt
			return
		end

		if self.sleep > 0 then
			self.sleep = math.max(self.sleep - dt, 0)
			return
		end

		local script = self.eventData[self.current]
		local player = state:get("player")
		local map = state:get("map")

		if script.command == "freeze" then
			player.freeze = script.args
		elseif script.command == "condition" then
			local object = state:call("findObject", script.args[1])
			if script.args[3] == "greater" then
				if object then
					if object[script.args[2]] < script.args[4] then
						self.sleep = dt
						self.current = self.current - 1
					end
				end
			elseif script.args[3] == "less" then
				if object[script.args[2]] > script.args[4] then
					self.sleep = dt
					self.current = self.current - 1
				end
			end
		elseif script.command == "function" then
			if script.args[1] == "player" then
				player[script.args[2]](player, unpack(script.args[3]))
			else
				local object = state:call("findObject", script.args[1])

				if object then
					object[script.args[2]](object, unpack(script.args[3]))
				end
			end
		elseif script.command == "sleep" then
			self.sleep = script.args
		elseif script.command == "dialog" then
			local object = state:call("findObject", script.args[1])

			if object and object.talk then
				object:talk(script.args[2], self.autoScroll)
			else
				state:call("addDialog", script.args[1], script.args[2])
			end
		elseif script.command == "shake" then
			if script.args > 0 then
				state:call("shake", script.args)
			elseif script.args == 0 then
				self.shakeLoop = false
			elseif script.args == -1 then
				self.shakeLoop = true
			end
		elseif script.command == "stopmusic" then
			if self.music and self.music:isPlaying() then
				self.music:stop()
				self.music = nil
			end
	
			local music = state:get("music")
			
			if music then
				music:stop()
			end
		elseif script.command == "playmusic" then
			if script.args then
				if self.music then
					self.music:stop()
				end

				self.music = love.audio.newSource("audio/music/" .. script.args .. ".ogg")
				self.music:setLooping(true)
				self.music:play()
			else
				local music = state:get("music")
				
				if music then
					music:play()
				end
			end
		elseif script.command == "spawn" then
			local layers = state:get("layers")
			if _G[script.args[1]] then
				_G[script.args[1]]:new(layers[3], script.args[2], script.args[3])
			end
		elseif script.command == "fadeout" then
			map.changeMap = true
		elseif script.command == "fadein" then
			map.changeMap = false
		elseif script.command == "playsound" then
			if _G[script.args] then
				_G[script.args]:play()
			end
		end

		if self.current < #self.eventData then
			self.current = self.current + 1
		else
			self.running = false
			CUTSCENES[self.name][2] = true

			if self.save then
				save:encode()
			end
		end
	end

	if self.shakeLoop then
		if state:get("shakeValue") == 0 then
			self.shakeTimer = self.shakeTimer + dt

			if self.shakeTimer > 1 then
				state:call("shake", math.random(0.5, 6))
				self.shakeTimer = math.random(0.5, 1)
			end
		end
	end
end

function event:isRunning()
	return self.running
end

return event:new()