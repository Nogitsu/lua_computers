LuaComputers.AddNetwork( "Print" )
LuaComputers.AddNetwork( "Error" )

local origin_type = 0
if CLIENT then
    LuaComputers.OnNetwork( "Print", function( ... )
        send_to_others = true
        
        LuaComputers.AddTerminalText( ... )
    end )
else
    LuaComputers.OnNetwork( "Print", function( ply, ... )
        local targets = player.GetHumans()
        table.RemoveByValue( targets, ply )

        LuaComputers.CallNetwork( "Print", targets, ... )
    end )
end

function LuaComputers.AddTerminalText( ... )
    if CLIENT then
        if IsValid( LuaComputers.terminal ) and IsValid( LuaComputers.terminal.console ) then            
            for i, v in ipairs( { ... } ) do
                if istable( v ) and v.r and v.g and v.b then
                    LuaComputers.terminal.console:InsertColorChange( v.r, v.g, v.b, v.a or 255 )
                else
                    LuaComputers.terminal.console:AppendText( tostring( v ) )
                end
            end

            LuaComputers.terminal.console:AppendText( "\n" )
            LuaComputers.terminal.console:GotoTextEnd()
        end

        if send_to_others then
            LuaComputers.CallNetwork( "Print", ... )
        end
    else
        LuaComputers.CallNetwork( "Print", player.GetHumans(), ... )
    end

    send_to_others = false
end

function LuaComputers.Print( ... )
    local str = ""

    for k, v in ipairs( { ... } ) do
        str = str .. tostring( v ) .. "\t"
    end

    LuaComputers.AddTerminalText( SERVER and Color( 137, 222, 255 ) or Color( 255, 222, 102 ), ( SERVER and "[Server] " or ( "[Client:" .. LocalPlayer():Name() .. "(" .. LocalPlayer():SteamID() .. ")] " ) ), str )
end

function LuaComputers.Error( ... )
    local str = ""

    for k, v in ipairs( { ... } ) do
        str = str .. tostring( v ) .. "\t"
    end

    if CLIENT then
        LuaComputers.AddTerminalText( Color( 255, 0, 0 ), "[Client:" .. LocalPlayer():Name() .. "(" .. LocalPlayer():SteamID() .. ")]\n\t", Color( 255, 255, 0 ), str )
    else
        LuaComputers.AddTerminalText( Color( 255, 0, 0 ), "[Server] ", str )
    end
end

LuaComputers.AddEnvironment( "terminal", {
    print = function( ... )
        LuaComputers.Print( ... )
    end,
    math = math,
} )