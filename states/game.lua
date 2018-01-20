local game = class("game")

function game:initialize()
	self.world = { ["back"] = {}, ["front"] = {} }

	self.player = player:new(self.world["front"], unpack(PLAYERSPAWN))
end

function game:load()
	print(self.player.x, self.player.y, self.player.category)
end

function game:update(dt)
	save:getActiveFile():tick(dt)

	for k, v in ipairs(self.world["front"]) do
		v:update(dt)
	end
end

function game:draw()
	for k, v in ipairs(self.world["front"]) do
		v:draw()
	end
end

function game:keypressed(key)
	if key == "a" then
		save:encode()
		state:change("title")
	end
end

return game