function love.system.getOS()
	return "Horizon"
end

function love.system.getModel()
	return "O3DS"
end

function love.system.getProcessorCount()
	return 2
end

function love.system.getRegion()
	return "USA"
end

function love.system.getLanguage()
	return "English"
end

function love.system.getUsername()
	return CONFIG.USERNAME
end

local oldPowerInfo = love.system.getPowerInfo
function love.system.getPowerInfo()
	local state, battery, seconds = oldPowerInfo()

	if battery ~= nil then
		return state, battery, nil
	end
	return "charging", 100, nil
end