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