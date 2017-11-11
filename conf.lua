function love.conf(t)
	t.console = false
	t.identity = "TurtleTale"

	if love._os then
		t.window.width = 400
		t.window.height = 480

		t.window.title = "Turtle Tale"
		t.window.highdpi = true
		t.window.icon = "graphics/icon.png"

		t.window.vsync = true
		t.window.fullscreentype = "exclusive"
	end
end
