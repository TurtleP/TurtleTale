local state = class("state")

function state:initialize()
	self.states = {}
	self.currentState = nil

	local items = love.filesystem.getDirectoryItems("states")

	for i = 1, #items do
		self:registerState(items[i]:gsub(".lua", ""))
	end
end

function state:registerState(name)
	assert(type(name) == "string",
	"invalid name: expected string.")

	print(name)
	local reg = require("states." .. name)
	self.states[name] = reg:new()
end

function state:hasState(name)
	if name then
		return self.states[name] ~= nil
	end

	return self.currentState ~= nil
end

function state:call(name, ...)
	local args = {...}
	if self:hasState() then
		if self:hasMethod(name) then
			return self.currentState[name](self.currentState, unpack(args))
		end
	end
end

function state:hasMethod(method)
	if self:hasState() then
		return self.currentState[method] ~= nil
	end
end

function state:get(var)
	if self:hasState() then
		return self.currentState[var]
	end
end

function state:load(...)
	if not self:hasState() then
		return
	end

	local args = {...}

	if type(args[1]) == "function" then
		args[1]()
		table.remove(args, 1)
	end

	if self.currentState.load then
		self.currentState:load(unpack(args))
	end
end

function state:destroy()
	if not self:hasState() then
		return
	end

	if self.currentState.destroy then
		self.currentState:destroy()
	end
end

function state:change(name, ...)
	self:destroy()

	self.currentState = self.states[name]

	self:load(...)
end

function state:update(dt)
	dt = math.min(1 / 60, dt)

	if not self:hasMethod("update") then
		return
	end

	self.currentState:update(dt)
end

function state:draw()
	if not self:hasMethod("draw") then
		return
	end

	self.currentState:draw()
end

function state:keypressed(key)
	if not self:hasMethod("keypressed") then
		return
	end

	self.currentState:keypressed(key)
end

function state:keyreleased(key)
	if not self:hasMethod("keyreleased") then
		return
	end
	
	self.currentState:keyreleased(key)
end

function state:mousepressed(x, y, button)
	if not self:hasMethod("mousepressed") then
		return
	end

	self.currentState:mousepressed(x, y, button)
end

function state:wheelmoved(x, y)
	if not self:hasMethod("wheelmoved") then
		return
	end

	self.currentState:wheelmoved(x, y)
end

return state:new()