function string.StartsWith( str, text )
    return str:sub( 1, #text ) == text
end

function string.EndsWith( str, text )
    return text == "" or str:sub( -#text ) == text
end

function string.ToTable( str )
	local tbl = {}

	for i = 1, str:len() do
		tbl[i] = str:sub( i, i )
	end

	return tbl
end

function string.Split( str, separator )
	if ( separator == "" ) then return str:ToTable() end

	local ret = {}
	local current_pos = 1

	for i = 1, str:len() do
		local start_pos, end_pos = str:find( separator, current_pos )
        
		if not start_pos then break end
        
		ret[ i ] = str:sub( current_pos, start_pos - 1 )
		current_pos = end_pos + 1
	end

	ret[ #ret + 1 ] = str:sub( current_pos )

	return ret
end
