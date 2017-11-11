bed = class("bed")

function bed:init(x, y, properties)
	self.x = x
	self.y = y - 1

	self.width = 32
	self.height = 16

	self.quadi = 1
	self.timer = 0

	self.screen = "top"

	self.used = false
	self.useTimer = 0.5

	self.player = nil

	local scale = 1
	if properties.scale then
		scale = properties.scale
	end
	self.scale = scale

	local offset = 0
	if scale < 1 then
		offset = self.width
	end
	self.offset = offset
end

function bed:update(dt)
	self.useTimer = math.max(self.useTimer - dt, 0)

	if self.player then
		self.timer = self.timer + dt
		self.quadi = 1 + math.floor(self.timer % 4) + 1

		self.player.x = self.x + self.width / 2
		self.player.y = self.y

		if self.useTimer == 0 then
			if self.player.useKey then
				self:use()
				self.useTimer = 0.5
			end
		end
	else
		local ret = checkrectangle(self.x, self.y, self.width, self.height, {"player"}, self)

		if #ret > 0 then
			if ret[1][2].useKey then
				self.used = true
			end

			if self.used then
				if self.useTimer == 0 then
					self:use(ret[1][2])
					self.useTimer = 0.5
				end
				self.used = false
			end
		end
	end
end

function bed:draw()
	love.graphics.draw(bedImage, bedQuads[self.quadi], self.x + self.offset, self.y, 0, self.scale, 1)

	if self.player then
		if math.floor(self.timer) % 2 == 0 then
			love.graphics.print("z", self.x + 12, self.y - 14)
		end
	end
end

function bed:use(player)
	if player then
		self.player = player
		player.x = self.x + 8
		player.y = self.y - 14
		player:setRender(false)
	else
		self.player:setRender(true)
		self.player = nil
		self.quadi = 1
	end
end