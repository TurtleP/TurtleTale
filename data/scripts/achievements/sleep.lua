local time = 0
local CAN_UNLOCK = true
local isAlive = true

return
{
	name = "Lazy Turtle",
	alive = true,
	quadi = 1,
	
	update = function(dt)
		local map = state:get("map")
		local player = state.states["game"].player

		if map and map.name == "indoors" then
			if not event:isRunning() then
				if player then
					if not player.active then
						time = time + dt
						if time > 5 then
							map.changeMap = true
							if map.fade == 1 then
								--game over lol
								isAlive = false
							end
						end
					else
						CAN_UNLOCK = false
						isAlive = false
					end
				end
			end
		end

		return { alive = isAlive, unlocked = CAN_UNLOCK }
	end
}