--  > http://www.computercraft.info/wiki/OS_(API)
local os = {
    _computer = {
        id = 0,
        label = nil,
        start_time = CurTime(),
    }
}

function os.version()
    return "gnOS v" .. LuaComputers.version
end

function os.getComputerID()
    return os._computer.id
end

function os.getComputerLabel()
    return os._computer.label
end

function os.setComputerLabel( label )
    os._computer.label = tostring( label )
end

function os.clock()
    return CurTime() - os._computer.start_time
end

function os.startTimer( timeout )
end

function os.cancelTimer( timerID )
end

function os.time()
    return RealTime()
end

function os.sleep( time )
    local thread = coroutine.running()
    
    timer.Simple( time, function()
        local success, error = coroutine.resume( thread )
        if not success then
            LuaComputers.Error( "Error:", error )
        end
    end )

    coroutine.yield()
end

function os.setAlarm( time )
end

function os.cancelAlarm( alarmID )
end

os.shutdown = coroutine.yield

function os.reboot()
    timer.Simple( 0, function()
	    LuaComputers.RunFile( "startup.lua", "BasicComputer" )
    end )

    os.shutdown()
end

return os