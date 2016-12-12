function love.load()
    imgData = love.image.newImageData("tiles.png")

    mask = {}

    for y = 1, (imgData:getHeight() / 17) do
        for x = 1, (imgData:getWidth() / 17) do
            r, g, b, a = imgData:getPixel((x * 17) - 1, (y - 1) * 17)
            
            --print((x - 1) * 16 + 17, (y - 1) * 17)
            local r = (y - 1) * (imgData:getWidth() / 17) + x
            if not mask[r] then
                mask[r] = {passive = true}
            end

            if a > 127 then
                mask[r].passive = false
            end
        end
    end

    file = love.filesystem.newFile("values.lua", "w")

    file:write("tilesMask = \n{\n")

    for x = 1, #mask do
        file:write("\t[" .. x ..  "] = { passive = " .. tostring(mask[x].passive) .. " },\n")
    end

    file:write("}")

    love.system.openURL(love.filesystem.getSaveDirectory())
end