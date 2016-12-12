barrier = class("barrier")

function barrier:init(x, y, width, height)
    self.x = x
    self.y = y

    self.width = width
    self.height = height

    self.category = 3

    self.screen = "top"

    self.active = true
    self.static = true
end