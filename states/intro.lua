local bubbles = {}

function introInit()
	introTurtleFade = 1
	introPotionFade = 0

	introTimer = 0
end

function introUpdate(dt)
	introTimer = introTimer + dt
	if introTimer > 1 and introTimer < 4 then
		introTurtleFade = math.max(introTurtleFade - 0.6 * dt, 0)
		introPotionFade = math.min(introPotionFade + 0.6 * dt, 1)
	end

	if introTimer > 6 then
		gameFunctions.changeState("title")
		introTimer = 0
	elseif introTimer > 4 then
		introPotionFade = math.max(introPotionFade - 0.6 * dt, 0)
	end

	if love.math.random(10) == 1 then
		createBubble()
	end

	for k, v in pairs(bubbles) do
		v:update(dt)
	end
end

function introDraw()
	love.graphics.setScreen("top")
	love.graphics.setColor(255, 255, 255, 255 * introTurtleFade)
	love.graphics.draw(introImage, gameFunctions.getWidth() / 2 - introImage:getWidth() / 2, gameFunctions.getHeight() / 2 - introImage:getHeight() / 2)

	love.graphics.setFont(endFont)
	shadowPrint("A game by TurtleP", gameFunctions.getWidth() / 2 - endFont:getWidth("A game by TurtleP") / 2, gameFunctions.getHeight() * .75, introTurtleFade)

	love.graphics.setColor(255, 255, 255, 255 * introPotionFade)

	for k, v in pairs(bubbles) do
		v:draw()
	end

	love.graphics.draw(potionImage, gameFunctions.getWidth() / 2 - potionImage:getWidth() / 2, gameFunctions.getHeight() / 2 - potionImage:getHeight() / 2)
end

function skipIntro()
	if introTimer > 0.5 then
		gameFunctions.changeState("title")
	end
end

function introKeypressed(key)
	skipIntro()
end

function createBubble()
	local newBubble = {x = 0, y = 0, speed = 0, size = 0, states = {'bottom', 'top'}}

	newBubble.speed = math.random(50, 125)
	newBubble.size = 32
	newBubble.x = math.random(-400, 400)
	newBubble.y = love.graphics.getHeight() + newBubble.size
	newBubble.img = love.graphics.newImage("graphics/intro/bubble.png")

	function newBubble:update(dt)
		self.y = self.y - self.speed * dt
	end

	function newBubble:draw()
		love.graphics.draw(self.img, self.x, self.y)
	end

	table.insert(bubbles, newBubble)
end