tile = class("tile")

function tile:init(x, y, width, height, properties)
	self.x = x
	self.y = y
	
	self.width = width or 16
	self.height = height or 16

	self.r = r

	self.category = 1

	self.active = true
	self.static = true

	self.speedx = 0
	self.speedy = 0
	
	self.screen = "top"

	for k, v in pairs(properties) do
		self[k] = v
	end

	if self.invisible ~= nil then
		self.passive = true

		self.setVisible = function(self, set, passive)
			self.invisible = set

			if not passive then
				self.passive = true
			else
				self.passive = passive
			end
			table.insert(MAP_DATA[tiled:getMapName()], {self.x, self.y, true})
		end

		self.fix = function(self)
			if self.id == 157 then
				self:setVisible(not cutscenes["mountain"][2])
			else
				self:setVisible(not cutscenes["hermitboss"][2], true)
			end
		end

		self.draw = function(self)
			if not self.invisible then
				if self.id == 157 then
					if #checkrectangle(self.x, self.y, self.width, self.height, {"exclude", self}) > 0 then
						self.passive = true
					else
						self.passive = false
					end
				end

				for i = 1, self.width / 16 do
					love.graphics.draw(gameTiles, tileQuads[self.id], self.x + (i - 1) * 16, self.y)
				end
			end
		end
	elseif self.breakable then
		self.draw = function(self)
			love.graphics.draw(gameTiles, tileQuads[self.id], self.x, self.y)
		end

		self.destroy = function(self)
			self.remove = true

			local color = nil
			if self.id == 305 then
				color = {26, 24, 15}
			elseif self.id == 71 then
				color = {92, 154, 155}
			end

			table.insert(prefabs, rock:new(self.x, self.y, {-32, -64}, color, false))
			table.insert(prefabs, rock:new(self.x + self.width, self.y, {32, -64}, color, false))

			if MAP_DATA[tiled:getMapName()] then
				table.insert(MAP_DATA[tiled:getMapName()], {self.x, self.y, false})
			end

			if math.random() < 0.3 then
				table.insert(objects["coin"], coin:new(self.x + self.width / 2 - 3, self.y))
			end
		end
	end
end