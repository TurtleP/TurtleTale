local Enum = {}

function Enum.new(values)
	local enum = {}

	for i = 1, #values do
		enum[values[i]] = values[i]
	end

	return enum
end

return setmetatable(Enum, {
	__call = function(_, ...) return Enum.new(...) end,
})