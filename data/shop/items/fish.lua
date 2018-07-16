return
{
	name = "Fish",
	cost = 1,
	description = "Heals you for 1 HP. Less health makes it a bit more expensive.",
	reuse = true,
	func = function(self, player, init)
		self.cost = self.cost + (player.maxHealth - player.health)

		if not init then
			player:addLife(1)
		end
	end
}