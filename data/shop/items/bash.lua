return
{
	name = "Shoulder Bash",
	cost = 0,
	description = "Ah. I see you are a creature of culture as well. Charge at enemies with this!",
	reuse = false,
	func = function(self, player, init)
		if not init then
			if not event:isRunning() and not CUTSCENES["shoulderbash"][2] then
				event:load("shoulderbash", CUTSCENES["shoulderbash"][1])
			end
		end
	end
}