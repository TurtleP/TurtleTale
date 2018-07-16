return function()
	if shop.timer == 0 then
		if not SHOP_OPEN then
			SHOP_OPEN = true

			state:get("player").freeze = not state:get("player").freeze
			
			shop.timer = 1
		end
	end
end