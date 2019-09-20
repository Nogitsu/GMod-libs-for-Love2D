function string.StartsWith( str, text )
    return str:sub( 1, #text ) == text
end

function string.EndsWith( str, text )
    return text == "" or str:sub( -#text ) == text
end