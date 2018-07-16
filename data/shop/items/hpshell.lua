return
{
	name = "Vitality Shell",
	cost = 20,
	description = "A brand new shell. Smells of fresh pines. Gives you a bonus heart.",
	reuse = false,
	func = function(self, player, init)
		if not init then
			player:addLife(1)
		end
	end
}