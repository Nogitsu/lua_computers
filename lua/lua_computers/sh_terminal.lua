LuaComputers.AddNetwork( "Print" )
LuaComputers.AddNetwork( "Error" )

local origin_type = 0
if CLIENT then
    LuaComputers.OnNetwork( "Print", function( origin, ... )
        origin_type = origin
        
        LuaComputers.AddTerminalText( ... )
    end )
else
    LuaComputers.OnNetwork( "Print", function( ply, ... )
        local targets = player.GetHumans()
        table.RemoveByValue( targets, ply )

        LuaComputers.CallNetwork( "Print", targets, 2, ... )
    end )
end

function LuaComputers.AddTerminalText( ... )
    if CLIENT then
        if IsValid( LuaComputers.terminal ) and IsValid( LuaComputers.terminal.console ) then            
            --[[ if origin_type == 1 then
                LuaComputers.terminal.console:InsertColorChange( 137, 222, 255, 255 )
            else
                LuaComputers.terminal.console:InsertColorChange( 255, 222, 102, 255 )
            end ]]
            for i, v in ipairs( { ... } ) do
                if IsColor( v ) then
                    LuaComputers.terminal.console:InsertColorChange( v.r, v.g, v.b, v.a )
                else
                    LuaComputers.terminal.console:AppendText( v--[[ ( ( origin_type == 1 ) and "Server: " or "Client: " ) .. str .. "\n" ]] )
                    LuaComputers.terminal.console:GotoTextEnd()
                end
            end
            LuaComputers.terminal.console:AppendText( "\n" )
        end

        if origin_type == 0 then
            LuaComputers.CallNetwork( "Print", ... )
        end
    else
        LuaComputers.CallNetwork( "Print", player.GetHumans(), 1, ... )
    end

    origin_type = 0
end

function LuaComputers.Print( ... )
    local str = ""

    for k, v in ipairs( { ... } ) do
        str = str .. tostring( v ) .. "\t"
    end

    LuaComputers.AddTerminalText( SERVER and Color( 137, 222, 255 ) or Color( 255, 222, 102 ), ( SERVER and "Server: " or "Client: " ) .. str )
end

LuaComputers.AddEnvironment( "terminal", {
    print = function( ... )
        LuaComputers.Print( ... )
    end,
    math = math,
} )