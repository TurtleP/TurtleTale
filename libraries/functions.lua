function print_r (t, indent) --Not by me
	local indent = indent or ''
	
	for key,value in pairs(t) do
		
		print(indent,'[',tostring(key),']')

		if type(value) == "table" then 
			print(':\n') 
			--print_r(value, indent .. '\t')
		else 
			print(' = ', tostring(value), '\n') 
		end
	end
end

function SecondsToClock(seconds) -- https://gist.github.com/jesseadams/791673
	local seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00:00";
	else
		hours = string.format("%02.f", math.floor(seconds / 3600));
		mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)));
		secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
		return hours .. ":" .. mins .. ":" .. secs
	end
end

function string:split(delimiter) --Not by me
	local result = {}
	local from  = 1
	local delim_from, delim_to = string.find( self, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( self, from , delim_from-1 ) )
		from = delim_to + 1
		delim_from, delim_to = string.find( self, delimiter, from  )
	end
	table.insert( result, string.sub( self, from  ) )
	return result
end

function string:hasExtension(extension)
	return self:sub(-#extension) == extension
end