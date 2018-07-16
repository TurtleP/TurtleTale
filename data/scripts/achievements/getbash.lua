local CAN_UNLOCK = false
local ALIVE = true

return
{
	name = "Buff Tortoise",
	quadi = 2,
	alive = true,

	source = 
	{
		class = "player",
		func  = "getAbility"
	},

	hook = function(self, ability)
		if ability == "punch" then
			CAN_UNLOCK = true
		end
	end,

	update = function(dt)
		return { alive = ALIVE, unlocked = CAN_UNLOCK }
	end
}