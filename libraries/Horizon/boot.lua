bootFont = {love.graphics.newFont(20), love.graphics.newFont(18)}
BOOT_TIME = 1
QUIT = false

local function draw()
	love.graphics.setFont(bootFont[1])

	love.graphics.setScreen("top")
	love.graphics.print("Homebrew", love.graphics.getWidth() / 2 - bootFont[1]:getWidth("Homebrew") / 2, love.graphics.getHeight() / 2 - bootFont[1]:getHeight() / 2)

	love.graphics.setFont(bootFont[2])

	love.graphics.setScreen("bottom")
	love.graphics.print("Homebrew", love.graphics.getWidth() / 2 - bootFont[2]:getWidth("Homebrew") / 2, love.graphics.getHeight() - bootFont[2]:getHeight())

	love.graphics.present()
end

draw()

while true do
	for e, a, b, c, d in love.event.poll() do
		print(e)
		if e == "quit" then
			QUIT = true
		end	
	end

	if QUIT then
		love.event.quit()
		break
	end

	love.event.pump()

	love.timer.sleep(0.001)

	BOOT_TIME = BOOT_TIME - love.timer.getDelta() * 0.001

	if BOOT_TIME <= 0 then
		break
	end
end

love.graphics.setScreen("top")
love.graphics.setNewFont(14)