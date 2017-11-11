eventsystem = class("eventsystem")

local skippables =
{
	"dialog",
	"sleep",
	"shake",
	"dofunction",
	"fadein",
	"fadeout",
	"spawncharacter",
	"freezeplayer",
	"playsound"
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
	if gameOver then
		return
	end

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
		if not self.skip then
			if self.sleep > 0 then
				self.sleep = math.max(0, self.sleep - dt)
			end

			if #dialogs > 0 then
				self.sleep = dt
			end
		else
			if not gameFadeOut then
				self.sleep = 0
			else
				self.sleep = dt
				if gameFade == 1 then
					gameFadeOut = false

					if self.gameEvent then
						--GAME_EVENTS[self.gameEvent] = true
					end
				end
			end
		end

		if self.sleep == 0 and self.running then
			self.i = self.i + 1

			local v = self.events[self.i]

			cmd = v.cmd:lower()

			if cmd == "dialog" then
				table.insert(dialogs, dialog:new(unpack(v.args)))
			elseif cmd == "playerx" then
				if v.args[1] == ">" then
					if objects["player"][1].x < v.args[2] then
						self.i = self.i - 1
						self.sleep = dt
					end
				end
			elseif cmd == "hasability" then
				if not objects["player"][1]:hasAbility(v.args) then
					self.i = 0
				end
			elseif cmd == "enemycount" then
				if #objects[v.args[1]] ~= v.args[2] then
					self.i = self.i - 1
					self.sleep = dt
				end
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
					if objects["player"][1][v.args[2]] then
						objects["player"][1][v.args[2]](objects["player"][1], v.args[3])
					end
				elseif v.args[1] == "phoenix" then
					if not objects["phoenix"][1] then
						return
					end

					if v.args[2] == "flamethrower" then
						objects["phoenix"][1]:flamethrower("left")
					elseif v.args[2] == "setstate" then
						objects["phoenix"][1]:setState(v.args[3])
					elseif v.args[2] == "showbook" then
						objects["phoenix"][1]:enableBook()
					elseif v.args[2] == "setscale" then
						objects["phoenix"][1]:setScale(v.args[3])
					end
				elseif objects[v.args[1]] then
					for k, w in ipairs(objects[v.args[1]]) do
						local off
						if (w.x == v.args[2] and w.y == v.args[3]) then
							off = 4
						elseif k == v.args[2] then
							off = 3
						end
						
						if w[v.args[off]] then
							if type(v.args[off + 1]) == "table" then
								w[v.args[off]](w, unpack(v.args[off + 1]))
							else
								w[v.args[off]](w, v.args[off + 1])
							end
						end
					end
				else
					for i, s in ipairs(prefabs) do
						for j, w in ipairs(s) do
							if w.x == v.args[1] and w.y == v.args[2] then
								prefabs[i][j][v.args[3]](w, unpack(v.args[4]))
							end
						end
					end
				end
			elseif cmd == "spawn" then
				if v.args[1] == "prefab" then
					table.insert(prefabs, _G[v.args[2]]:new(v.args[3], v.args[4]))
				else
					table.insert(objects[v.args[1]], _G[v.args[2]]:new(v.args[3], v.args[4]))
				end
			elseif cmd == "setposition" then
				objects[v.args[1]][1].x, objects[v.args[1]][1].y = v.args[2], v.args[3]
			elseif cmd == "setspeed" then
				if not objects["phoenix"][1] then
					return
				end

				if v.args[1] == "phoenix" then
					objects["phoenix"][1].speedx, objects["phoenix"][1].speedy = v.args[2], v.args[3]
				elseif v.args[1] == "player" then
					objects["player"][1].speedx, objects["player"][1].speedy = v.args[2], v.args[3]
				end
			elseif cmd == "walkcharacter" then
				if v.args[1] == "player" then
					objects["player"][1][v.args[2]] = v.args[3]
				end
			elseif cmd == "removecharacter" then

			elseif cmd == "facedirection" then
				if v.args[1] == "enemy" then
					objects["enemy"][1]:faceDirection(v.args[2])
				end
			elseif cmd == "giveability" then
				objects["player"][1]:getAbility(v.args)
			elseif cmd == "freezeplayer" then
				objects["player"][1]:moveLeft(false)
				objects["player"][1]:moveRight(false)
				objects["player"][1]:freeze(true)
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
			elseif cmd == "playsound" then
				if _G[v.args] then
					_G[v.args]:play()
				end
			elseif cmd == "savegame" then
				saveManager:save(saveManager:getCurrentSave(), saveManager:generateSaveData())
			elseif cmd == "isdone" then
				if cutscenes[v.args] and cutscenes[v.args][2] ~= true then
					self.i = self.i - 1
					self.sleep = dt
				end
			end
		end
	else
		if self.running then
			tiled:playCurrentSong()
			self.skip = false
			self.running = false

			--[[if self.gameEvent and GAME_EVENTS[self.gameEvent] ~= nil then
				GAME_EVENTS[self.gameEvent] = true
			end]]
		end
		cutscenes[self.name][2] = true
		
		if self.save then
			print(saveManager:getCurrentSave())
			saveManager:save(saveManager:getCurrentSave(), saveManager:generateSaveData())
			self.save = false
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

function eventsystem:canSkip()
	local duration = 0
	for i, v in ipairs(self.events) do
		if v.cmd == "sleep" then
			duration = duration + v.args
		end
	end
	return duration > 0
end

function eventsystem:skipCutscene()
	if not self:canSkip() then
		return
	end

	gameFadeOut = true
	self.skip = true
	for k, v in ipairs(skippables) do
		for j, w in ipairs(self.events) do
			if v == w.cmd then
				table.remove(self.events, j)
			end
		end
	end
end

function eventsystem:decrypt(name, scriptString)
	for k, v in pairs(scriptString) do
		if type(v) == "table" then
			local cmd, arg = v[1], v[2]
			if cmd == "levelequals" then
				if tiled:getMapName() ~= arg then
					break
				end
			elseif cmd == "isdone" then
				if cutscenes[arg] and cutscenes[arg][2] ~= true then
					break
				end
			end

			if not self.name then
				self.gameEvent = scriptString.event
				self.save = scriptString.save
				self.name = name
			end

			self.running = true
			self:queue(cmd, arg)
		end
	end
end