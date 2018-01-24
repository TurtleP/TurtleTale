local achievement = class("achievement")

function achievement:initialize()
	self.achievments = {}
	local items = love.filesystem.getDirectoryItems("data/scripts/achievements")

	for i = 1, #items do
		self:register(items[i]:gsub(".lua", ""))
	end

	self.offset = 0

	self.unlocked = {}
end

function achievement:register(name)
	assert(type(name) == "string",
	"invalid name: expected string.")

	self.achievments[name] = require("data.scripts.achievements." .. name)
end

function achievement:update(dt)
	for k, v in pairs(self.achievments) do
		if v.alive then
			v.alive = v.update(dt)

			--[[if ret then
				v.alive = ret.alive
			end]]
		else
			if not self.unlocked[k] then
				self.offset = self.offset + 16
				self.unlocked[k] = { v.name, false }
			end
		end
	end
end

function achievement:draw() --draw the thing
	love.graphics.setScreen("top")

	for k, v in pairs(self.unlocked) do
		love.graphics.print(v[1], 0, 0)
	end
end

return achievement:new()