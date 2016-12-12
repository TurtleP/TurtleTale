eventsystem = class("eventsystem")

local blackList =
{
	["dialog"] = true,
	["sleep"] = true,
	["shake"] = true,
	["usedoor"] = true,
	["walkcharacter"] = true
}

function eventsystem:init()
	self.sleep = 0
	self.i = 0
	self.events = {}
	self.running = false
end

function eventsystem:update(dt)
	if not self.running then
		return
	end
	
	if self.i < #self.events then
		if self.sleep > 0 then
			self.sleep = math.max(0, self.sleep - dt)
		end

		if #dialogs > 0 then
			self.sleep = dt
		end

		if self.sleep == 0 and self.running then
			self.i = self.i + 1

			local v = self.events[self.i]

			cmd = v.cmd:lower()

			if cmd == "dialog" then
				table.insert(dialogs, dialog:new(unpack(v.args)))
			elseif cmd == "stopmusic" then
				love.audio.stop()
			elseif cmd == "playmusic" then
				_G[v.args]:play()
			elseif cmd == "sleep" then
				self.sleep = v.args
			elseif cmd == "spawncharacter" then
				if v.args[1] == "turtle" then
					objects[2][1] = turtle:new(v.args[2], v.args[3])
				elseif v.args[1] == "phoenix" then
					objects[4][1] = phoenix:new(v.args[2], v.args[3])
				end
			elseif cmd == "dofunction" then
				if v.args[1] == "player" then
					if v.args[2] == "use" then
						objects[2][1]:use(v.args[3])
					end
				elseif v.args[1] == "phoenix" then
					if v.args[2] == "flamethrower" then
						objects[4][1]:flamethrower("left")
					end
				end
			elseif cmd == "setposition" then
				if v.args[1] == "turtle" then
					objects[2][1].x, objects[2][1].y = v.args[2], v.args[3]
				end
			elseif cmd == "setspeedx" then
				if v.args[1] == "phoenix" then
					objects[4][1].speedx = v.args[2]
				end
			elseif cmd == "setspeedy" then
				if v.args[1] == "phoenix" then
					objects[4][1].speedy = v.args[2]
				end
			elseif cmd == "walkcharacter" then

			elseif cmd == "removecharacter" then

			elseif cmd == "facedirection" then
				if v.args[1] == "enemy" then
					objects["enemy"][1]:faceDirection(v.args[2])
				end
			elseif cmd == "freezeplayer" then
				objects[2][1]:freeze(true)
			elseif cmd == "unfreezeplayer" then
				objects[2][1]:freeze(false)
			elseif cmd == "shake" then
				shakeValue = v.args
			elseif cmd == "changestate" then
				util.changeState(v.args)
			elseif cmd == "killplayer" then
				objects["player"][1]:die(true)
			elseif cmd == "fadein" then
				gameFade = 1
				gameFadeOut = false
				fadeValue = v.args or 1
			elseif cmd == "disable" then
				self.disabled = true
			elseif cmd == "fadeout" then
				gameFade = 0
				gameFadeOut = true
				fadeValue = v.args or 1
			elseif cmd == "setmap" then
				tiled:setMap(v.args)
			end
		end
	else
		if self.running then
			self.running = false
			currentScript = currentScript + 1
		end
	end
end

function eventsystem:isRunning()
	return self.running
end

function eventsystem:queue(e, args)
	table.insert(self.events, {cmd = e, args = args})
end

function eventsystem:clear()
	self.events = {}
end

function eventsystem:decrypt(scriptString)
	for k, v in ipairs(scriptString) do
		local cmd, arg = v[1], v[2]
		if cmd == "levelequals" then
			if tiled:getMapName() ~= arg then
				print("Won't load script {Level Equals: " .. arg .. "} (doesn't belong to level!)")
				break
			else
				print("Using script {Level Equals: " .. arg .. "}")
			end
		end

		self.running = true

		if deathRestart then
			if not blackList[cmd] then
				self:queue(cmd, arg)
			end
		else
			self:queue(cmd, arg)
		end
	end
end