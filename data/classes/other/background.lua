local Object = require("libraries.classic")
local Background = Object:extend()

Background.textures =
{
    Mountain =
    {
        Day =
        {
            {love.graphics.newImage("graphics/backgrounds/sky.png"), -love.graphics.getHeight()},
            {love.graphics.newImage("graphics/backgrounds/mountains.png"), -352, norepeat = true},
            {love.graphics.newImage("graphics/backgrounds/trees.png"), -256}
        }
    },

    Forest =
    {
        {love.graphics.newImage("graphics/backgrounds/sky.png"), -love.graphics.getHeight()},
        {love.graphics.newImage("graphics/backgrounds/trees.png"), -256}
    }
}

function Background:new(data)
    local textures

    local name, flags = unpack(data:split(";"))

    if name == "Mountain" then
        textures = Background.textures[name][flags]
    else
        textures = Background.textures[name]
    end

    self.textures = textures
end

function Background:draw(width)
    for i = 1, #self.textures do
        local currentTexture, height = self.textures[i], love.graphics.getHeight()

        for x = 1, math.floor(width / currentTexture[1]:getWidth()) + 1 do
            if not currentTexture.norepeat then
                love.graphics.draw(currentTexture[1], ((x - 1) * currentTexture[1]:getWidth()), (height + currentTexture[2]))
            end
        end

        if currentTexture.norepeat then
            love.graphics.draw(currentTexture[1], 0, height + currentTexture[2])
        end
    end
end

return Background