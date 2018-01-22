guiBase = class("guiBase")

require 'classes.gui.imagebutton'

function guiBase:initialize(x, y, width, height, flags)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	for k, v in pairs(flags) do
		self[k] = v
	end
end