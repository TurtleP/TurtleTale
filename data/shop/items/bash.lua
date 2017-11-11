return
{
	name = "Shoulder Bash",
	cost = 0,
	description = "Ah. I see you are a creature of culture as well. Charge at enemies with this!",
	reuse = false,
	func = function(self, player, init)
		if not init then
			eventSystem:decrypt("shoulderbash", cutscenes["shoulderbash"][1])
		end
	end
}