return
{
	name = "Shell Wax",
	cost = 3,
	description = "Grants protection over one heart. Less expensive with lower health.",
	reuse = true,
	func = function(self, player, init)	
		--self.cost = self.cost - (player:getMaxHealth() - player:getHealth())
	end
}