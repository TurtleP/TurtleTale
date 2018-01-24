return
{
	["cliff"] =
	{

		{	
			x = 112, 
			y = 96, 
			func = function(self)
				gameNewDialog(nil, "Obtained 5 shells! Use these to purchase items from the Hermit Shack!")
				objects["player"][1]:addMoney(5)
				self.used = true
			end,
			used = false
		}
	},

	["mountain_1-2"] =
	{
		{	
			x = 448, 
			y = 48, 
			func = function(self)
				gameNewDialog(nil, "Obtained 3 shells! Use these to purchase items from the Hermit Shack.")
				objects["player"][1]:addMoney(3)
				self.used = true
			end,
			used = false
		}
	},

	["beach_home-2"] =
	{
		{
			x = 152,
			y = 128,
			func = function(self)
				gameNewDialog(nil, "Obtained 2 shells! Use these to purchase items from the Hermit Shack.")
				objects["player"][1]:addMoney(2)
				self.used = true
			end,
			used = false
		}
	},

	["beach_home-3"] =
	{
		{
			x = 272,
			y = 48,
			func = function(self)
				gameNewDialog(nil, "You found 2 water vials! Use these to recover lost health.")
				objects["player"][1].inventory:addItem("water", 2)
				self.used = true
			end,
			used = false
		}
	},

	["mountain_1-10"] = 
	{
		{
			x = 224,
			y = 208,
			func = function(self)
				gameNewDialog(nil, "You found a rope! Use it to escape to your last save point.")
				objects["player"][1].inventory:addItem("rope", 1)
				self.used = true
			end,
			used = false
		}
	}
}