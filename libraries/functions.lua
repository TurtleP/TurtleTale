function print_r (t, indent) -- alt version, abuse to http://richard.warburton.it
  local indent=indent or ''
  for key,value in pairs(t) do
    io.write(indent,'[',tostring(key),']') 
    if type(value)=="table" then io.write(':\n') print_r(value,indent..'\t')
    else io.write(' = ',tostring(value),'\n') end
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

function distance(x1, y1, x2, y2) 
	return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5 
end

function findInTable(t, find)
	local found = false
	for k, v in pairs(t) do
		if v == find then
			found = true
		end
	end
	return found
end