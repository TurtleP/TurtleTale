return
{
	name = "Heart Piece",
	cost = 10,
	description = "Grants an extra heart. You'll be able to take more damage before--well--dying.",
	reuse = false,
	func = function(self, player, init)
		if not init then
			player:addHeart()
			gameNewDialog(nil, "You got a heart container! Your max hearts has increased by one.")
		end
	end
}