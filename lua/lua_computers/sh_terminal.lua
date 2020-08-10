function LuaComputers.Print( ... )
    local str = ""

    for k, v in ipairs( { ... } ) do
        str = str .. tostring( v ) .. "\t"
    end

    if CLIENT then
        if IsValid( LuaComputers.terminal ) and IsValid( LuaComputers.terminal.console ) then
            LuaComputers.terminal.console:AppendText( str .. "\n" )
            LuaComputers.terminal.console:GotoTextEnd()
        end
    else
        print( "[LuaComputers] " .. str )
    end
end

LuaComputers.AddEnvironment( "terminal", {
    print = function( ... )
        LuaComputers.Print( ... )
    end
} )