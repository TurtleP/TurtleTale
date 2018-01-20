local Screen = Enum.new({"top", "bottom"})
local CURRENT_SCREEN = Screen.top
local CURRENT_FONT = nil

local SCISSOR = {
	top = {0, 0, 400, 240},
	bottom = {0, 0, 320, 240}
}

local IS_3D = false

local function translateCoordinates(x, y)
	if not x then
		x = 0
	end

	if not y then
		y = 0
	end

	if love.graphics.getScreen() == "bottom" then
		x = x + 40
		y = y + 240
	end

	return x, y
end

function love.graphics.set3D(enable) --stubbed
	assert(type(enable) == "boolean")
	IS_3D = enable
end

function love.graphics.setDepth(depth) --stubbed
	assert(type(depth) == "number")
end

local oldGraphicsScissor = love.graphics.setScissor
function love.graphics.setScissor(x, y, width, height)
	if x and y then
		x, y = translateCoordinates(x, y)
	end

	oldGraphicsScissor(x, y, width, height)
end

function love.graphics.setScreen(screen)
	assert(Screen[screen] and type(screen) == "string")
	CURRENT_SCREEN = Screen[screen]

	love.graphics.setScissor(unpack(SCISSOR[screen]))
end

function love.graphics.getScreen()
	return CURRENT_SCREEN
end

local oldGraphicsDraw = love.graphics.draw
function love.graphics.draw(image, ...) --image, x, y .. image, quad, x, y
	local args = {...}

	local offset = 1
	local quad = nil

	if type(args[1]) ~= "number" then
		offset = 2
		quad = args[1]
	end

	local x, y = translateCoordinates(args[offset + 0], args[offset + 1])

	if not quad then
		oldGraphicsDraw(image, x, y, args[offset + 2], args[offset + 3], args[offset + 4], args[offset + 5], args[offset + 6])
	else
		oldGraphicsDraw(image, quad, x, y, args[offset + 2], args[offset + 3], args[offset + 4], args[offset + 5], args[offset + 6])
	end
end

local oldGraphicsRectangle = love.graphics.rectangle
function love.graphics.rectangle(mode, x, y, ...)
	x, y = translateCoordinates(x, y)

	oldGraphicsRectangle(mode, x, y, ...)
end

local oldGraphicsLine = love.graphics.line
function love.graphics.line(x, y, x2, y2)
	x, y = translateCoordinates(x, y)
	x2, y2 = translateCoordinates(x2, y2)

	oldGraphicsLine(x, y, x2, y2)
end

local oldGraphicsCircle = love.graphics.circle
function love.graphics.circle(mode, x, y, ...)
	x, y = translateCoordinates(x, y)

	oldGraphicsCircle(mode, x, y, ...)
end

local oldGraphicsSetFont = love.graphics.setFont
function love.graphics.setFont(font)
	if type(font) == "userdata" then
		oldGraphicsSetFont(font)
		return
	end

	CURRENT_FONT = font
end

local oldGraphicsPrint = love.graphics.print
function love.graphics.print(text, x, y, ...)
	x, y = translateCoordinates(x, y)

	text = tostring(text)

	if not CURRENT_FONT then
		oldGraphicsPrint(text, x, y, ...)
		return
	end

	local font = CURRENT_FONT
	local width = 0

	for i = 1, #text do
		local glyph = font.chars[text:sub(i, i)]
		if text:sub(i, i) ~= "\n" then
			if i > 1 then
				width = width + font:getWidth(text:sub(i - 1, i - 1))
			end
			oldGraphicsDraw(font.bitmap, glyph.quad, x + width + glyph.xoffset, y + glyph.yoffset, ...)
		end
	end
end

local oldGraphicsGetWidth = love.graphics.getWidth
function love.graphics.getWidth()
	if love.graphics.getScreen() == "bottom" then
		return 320
	end
	return 400
end

function love.graphics.getRendererInfo()
	return "OpenGL ES", "1.1", "Digital Media Professionals Inc.", "DMP PICA200"
end

local oldGraphicsGetHeight = love.graphics.getHeight
function love.graphics.getHeight()
	return 240
end

local function renderSpace()
	love.graphics.setColor(66, 66, 66, 255)

	oldGraphicsRectangle("fill", 0, 240, 40, 240)
	oldGraphicsRectangle("fill", 360, 240, 40, 240)
end

local oldDraw = love.draw
function love.draw()
	oldDraw()

	love.graphics.setScissor()

	renderSpace()

	love.graphics.setColor(255, 255, 255)
end