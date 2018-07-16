guiBase = class("guiBase")

require 'classes.gui.imagebutton'
require 'classes.gui.messagebox'

function guiBase:initialize(x, y, width, height, flags)
	self.x = x
	self.y = y

	self.width = width
	self.height = height

	self.origin = vector(x, y)

	if not flags then
		flags = {}
	end

	for k, v in pairs(flags) do
		if type(k) == "string" then
			self[k] = v
		end
	end
end