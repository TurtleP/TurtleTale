local CAN_UNLOCK = false
local ALIVE = true

return
{
	name = "Bat-tle Cry",
	alive = true,
	quadi = 4,

	source = 
	{
		class = "megabat",
		func  = "punch"
	},

	hook = function(self)
		if self.health == 1 then
			CAN_UNLOCK = true
			ALIVE = false
		end
	end,

	update = function(dt)
		return { alive = ALIVE, unlocked = CAN_UNLOCK }
	end
}