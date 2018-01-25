local achievement = class("achievement")

local achievementsImage = love.graphics.newImage("data/scripts/achievements/achievements.png")
local achievementsQuads = {}
for i = 1, achievementsImage:getWidth() / 18 do
	achievementsQuads[i] = love.graphics.newQuad((i - 1) * 18, 0, 18, 18, achievementsImage:getWidth(), achievementsImage:getHeight())
end

local hook = require 'libraries.hook'

function achievement:initialize()
	self.achievements = {}
	local items = love.filesystem.getDirectoryItems("data/scripts/achievements")

	for i = 1, #items do
		if items[i]:hasExtension(".lua") then
			self:register(i, items[i]:gsub(".lua", ""))
		end
	end

	self.offset = 0

	self.unlocked = {}

	self.width = 128
	self.height = 20

	self.maxHeight = SCREEN_HEIGHT
	self.last = nil
end

function achievement:register(i, name)
	assert(type(name) == "string",
	"invalid name: expected string.")

	local v = require("data.scripts.achievements." .. name)

	if v.hook and v.source then
		local func =_G[v.source.class][v.source.func]
		_G[v.source.class][v.source.func] = hook.add(func, v.hook)
	end

	self.achievements[name] = v

	print("Cached achievement data: " .. name)
end

function achievement:update(dt)
	for k, v in pairs(self.achievements) do
		if not v.unlocked and v.alive and v.update then
			local ret = v.update(dt)

			if ret then
				v.alive = ret.alive

				if ret.unlocked then
					self:unlock(k)
				end
			end
		end
	end

	for k, v in pairs(self.achievements) do
		if not v.loaded and v.unlocked then
			if v.open then
				v.y = math.max(v.y - 96 * dt, v.maxHeight)
			elseif v.open == false then
				v.y = math.min(v.y + 96 * dt, SCREEN_HEIGHT)

				if v.y == SCREEN_HEIGHT then
					v.loaded = true --stop rendering/updating
					self.offset = math.max(self.offset - self.height, 0)
				end
			end

			if v.y == v.maxHeight then
				v.timer = v.timer + dt
				if v.timer > 2 then
					v.open = false
				end
			end
		elseif v.loaded then
			self.offset = math.max(self.offset - self.height, 0)
		end
	end
end

function achievement:unlock(name, loaded)
	local v = self.achievements[name]
	
	v.open = true
	v.unlocked = true
	v.y = SCREEN_HEIGHT
	v.timer = 0

	self.offset = self.offset + self.height
	v.maxHeight = self.maxHeight - self.offset
end

function achievement:draw() --draw the thing
	love.graphics.setScreen("top")

	local x = TOPSCREEN_WIDTH - self.width
	for k, v in pairs(self.achievements) do
		if v.unlocked and not v.loaded then
			love.graphics.setColor(40, 40, 40, 128)
			love.graphics.rectangle("fill", x, v.y, self.width, self.height)

			love.graphics.setColor(255, 255, 255)
			love.graphics.print(v.name, x + 21, v.y + (self.height - gameFont:getHeight()) / 2)

			love.graphics.draw(achievementsImage, achievementsQuads[v.quadi], x + 1, v.y + 1)
		end
	end
end

return achievement:new()