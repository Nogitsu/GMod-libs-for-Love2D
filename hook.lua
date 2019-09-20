hook = {}
local hooks = {}

function hook.Add( event, name, callback )
    hooks[ event ] = hooks[ event ] or {}
    hooks[ event ][ name ] = callback
end

function hook.GetTable()
    return hooks
end

function hook.Remove( event, name )
    hooks[ event ] = hooks[ event ] or {}
    hooks[ event ][ name ] = nil
end

function hook.Run( event, ... )
    if not hooks[ event ] then return end

    for id, callback in pairs( hooks[ event ] ) do
        local result = callback( ... )
        if result then return true end
    end

    return false
end
