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

function os.sleep()
end

function os.setAlarm( time )
end

function os.cancelAlarm( alarmID )
end

function os.shutdown()
end

function os.reboot()
end

return os