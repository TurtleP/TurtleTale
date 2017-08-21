eventsystem = class("eventsystem")

local blackList =
{
	["dialog"] = true,
	["sleep"] = true,
	["shake"] = true,
	["dofunction"] = true,
	["fadein"] = true,
	["fadeout"] = true,
	["spawncharacter"] = {phoenix = true},
	["freezeplayer"] = true
}

function eventsystem:init()
	self.sleep = 0
	self.i = 0
	self.events = {}
	self.running = false
	self.shakeLoop = false
	self.shakeDelay = 2
end

function eventsystem:update(dt)
	if self.shakeLoop then
		if self.shakeDelay > 0 then
			if shakeValue == 0 then
				self.shakeDelay = self.shakeDelay - dt
			end
		else
			shakeValue = 12
			self.shakeDelay = math.random(1, 1.5)
		end
	end

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
				if not self.lastSong or v.args == "all" then
					love.audio.stop()
				else
					self.lastSong:stop()
					self.lastSong = nil
					collectgarbage()
					collectgarbage()
				end
			elseif cmd == "playmusic" then
				if v.args ~= "map" then
					self.lastSong = love.audio.newSource("audio/music/" .. v.args .. ".ogg", "stream")
					self.lastSong:setLooping(true)
					self.lastSong:play()
				else
					tiled:playCurrentSong()
				end
			elseif cmd == "sleep" then
				self.sleep = v.args
			elseif cmd == "spawncharacter" then
				if v.args[1] == "turtle" then
					objects["player"][1] = turtle:new(v.args[2], v.args[3])
				elseif v.args[1] == "phoenix" then
					objects["phoenix"][1] = phoenix:new(v.args[2], v.args[3])
				end
			elseif cmd == "dofunction" then
				if v.args[1] == "player" then
					if v.args[2] == "use" then
						objects["player"][1]:use(v.args[3])
					elseif v.args[2] == "jump" then
						objects["player"][1]:jump()
					elseif v.args[2] == "setscale" then
						objects["player"][1]:setScale(v.args[3])
					end
				elseif v.args[1] == "phoenix" then
					if v.args[2] == "flamethrower" then
						objects["phoenix"][1]:flamethrower("left")
					elseif v.args[2] == "setstate" then
						objects["phoenix"][1]:setState(v.args[3])
					elseif v.args[2] == "showbook" then
						objects["phoenix"][1]:enableBook()
					elseif v.args[2] == "setscale" then
						objects["phoenix"][1]:setScale(v.args[3])
					end
				end
			elseif cmd == "setposition" then
				objects[v.args[1]][1].x, objects[v.args[1]][1].y = v.args[2], v.args[3]
			elseif cmd == "setspeed" then
				if v.args[1] == "phoenix" then
					objects["phoenix"][1].speedx, objects["phoenix"][1].speedy = v.args[2], v.args[3]
				end
			elseif cmd == "walkcharacter" then

			elseif cmd == "removecharacter" then

			elseif cmd == "facedirection" then
				if v.args[1] == "enemy" then
					objects["enemy"][1]:faceDirection(v.args[2])
				end
			elseif cmd == "giveability" then
				objects["player"][1]:getAbility(v.args)
			elseif cmd == "freezeplayer" then
				objects["player"][1]:freeze(true)
				objects["player"][1]:moveRight(false)
				objects["player"][1]:moveLeft(false)
			elseif cmd == "unfreezeplayer" then
				objects["player"][1]:freeze(false)
			elseif cmd == "shake" then
				shakeValue = v.args
			elseif cmd == "changestate" then
				util.changeState(v.args)
			elseif cmd == "killplayer" then
				objects["player"][1]:die(true)
			elseif cmd == "fadein" then
				gameFade = 1
				gameFadeOut = false
				fadeValue = v.args or 2
			elseif cmd == "disable" then
				self.disabled = true
			elseif cmd == "fadeout" then
				gameFade = 0
				gameFadeOut = true
				fadeValue = v.args or 2
			elseif cmd == "setmap" then
				tiled:setMap(v.args)
			elseif cmd == "shakeloop" then
				self.shakeLoop = true
			end
		end
	else
		if self.running then
			self.running = false
			currentScript = currentScript + 1
			skipScene = false
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
				break
			end
		end

		self.running = true

		--[[if skipScene then
			if (type(blackList[cmd]) == "boolean" and not blackList[cmd]) or (type(blackList[cmd]) == "table" and not blackList[cmd][arg]) then
				self:queue(cmd, arg)
			end
		else]]
			self:queue(cmd, arg)
		--end
	end
end