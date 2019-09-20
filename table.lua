function table.Merge( a, b )
    if type(a) == 'table' and type(b) == 'table' then
        for k, v in pairs(b) do
            a[k] = v
        end
    end
    return a
end

function table.Random( tab )
    return tab[ math.random( #tab ) ]
end

function table.ClearKeys( tab )
    local new_table = {}
    local num = 1

    for k, v in pairs( tab ) do
        new_table[ num ] = v
        num = num + 1
    end

    return new_table
end

function table.Copy( tab )
    return { unpack( tab ) }
end

function table.Count( tab )
    local num = 0

    for k, v in pairs( tab ) do
        num = num + 1
    end

    return num
end
table.Lenght = table.Count

function table.Empty( tab )
    for k, v in pairs( tab ) do
        tab[ k ] = nil
    end
end

function table.Add( tab, value )
    tab[ #tab + 1 ] = value
end

function table.GetKeys( tab )
    local keys = {}

    for k, _ in pairs( tab ) do
        table.Add( keys, k )
    end

    return keys
end

function table.HasValue( tab, value )
    for k, v in pairs( tab ) do
        if v == value then return true end
    end

    return false
end

function table.KeyFromValue( tab, value )
    for k, v in pairs( tab ) do
        if v == value then return k end
    end
end

function table.KeysFromValue( tab, value )
    local keys = {}

    for k, v in pairs( tab ) do
        if v == value then
            table.Add( keys, k )
        end
    end

    return keys
end

function table.RemoveByValue( tab, value )
    for k, v in pairs( tab ) do
        if v == value then
            tab[ k ] = nil
        end
    end
end
