tile = class("tile")

function tile:init(x, y, width, height)
	self.x = x
	self.y = y
	
	self.width = width
	self.height = height

	self.r = r

	self.category = 1

	self.active = true
	self.static = true

	self.speedx = 0
	self.speedy = 0
	
	self.screen = "top"
end