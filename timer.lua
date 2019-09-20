timer = {}
local timers = {}

--  > Simple timer
function timer.Simple( time, callback )
    local timer = timer or love.timer.getDelta()
    timers[ #timers + 1 ] = { remaining = time, time = time, reps = 1, callback = callback or function() end }
end

--  > Timers with id access
function timer.Create( name, time, reps, callback )
    local timer = timer or love.timer.getDelta()
    timers[ name ] = { remaining = time, time = time, reps = reps or 1, callback = callback or function() end }
end

function timer.Exists( name )
    return timers[ name ]
end

function timer.Remove( name, execute )
    if not timers[ name ] then return false end

    if execute then timer[ name ].callback() end
    timers[ name ] = nil

    return true
end

function timer.Pause( name )
    if not timers[ name ] then return false end

    timers[ name ].paused = true

    return true
end

function timer.UnPause( name )
    if not timers[ name ] then return false end

    timers[ name ].paused = false

    return true
end
timer.Start = timer.UnPause

function timer.Toggle( name )
    if not timers[ name ] then return false end

    timers[ name ].paused = not timers[ name ].paused

    return true
end

function timer.Stop( name )
    if not timers[ name ] then return false end

    timers[ name ].paused = true
    timers[ name ].remaining = timers[ name ].time

    return true
end

function timer.TimeLeft( name )
    if not timers[ name ] then return false end

    return timers[ name ].remaining
end

function timer.RepsLeft( name )
    if not timers[ name ] then return false end

    return timers[ name ].reps
end

--  > Update timers' timing at good time

function timer.update( dt )
    for k, v in pairs( timers ) do
        if not v.paused then
            v.remaining = v.remaining - dt

            if v.remaining <= 0 then
                v.callback()

                if v.reps == 0 then
                    v.remaining = v.time
                else
                    v.reps = v.reps - 1
                    v.remaining = v.time

                    if v.reps == 0 then
                        timers[ k ] = nil
                    end
                end
            end
        end
    end
end
