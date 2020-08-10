LuaComputers.networks = {}

local events = {}

if SERVER then
    util.AddNetworkString( "LuaComputers" )
end

function LuaComputers.AddNetwork( name )
    local id = table.Count( LuaComputers.networks ) + 1

    if LuaComputers.networks[ name ] then
        MsgC( Color( 255, 0, 0 ), "[Info] ", CLIENT and Color( 255, 222, 102 ) or Color( 137, 222, 255 ), CLIENT and "Client: " or "Server: ", color_white, "Can't overwrite net '", name, "' with id ", id, "\n" )
        
        return
    end
    
    LuaComputers.networks[ name ] = id
end

function LuaComputers.CallNetwork( id, target, ... )
    if isstring( id ) then
        id = LuaComputers.networks[ id ]
    end

    if not id then 
        error( "Invalid net id" )
        return
    end
    
    local args = CLIENT and { target, ... } or { ... }
    local compressed = util.Compress( util.TableToJSON( args ) )

    net.Start( "LuaComputers" )
        net.WriteInt( id, 8 )

        if #args > 0 then
            net.WriteData( compressed, #compressed )
        end
    if CLIENT then
        net.SendToServer()
    else
        net.Send( target )
    end
end

function LuaComputers.OnNetwork( id, callback )
    if isstring( id ) then
        id = LuaComputers.networks[ id ]
    end

    if not id then 
        error( "Invalid net id" )
        return
    end

    if events[ id ] then
        MsgC( Color( 255, 0, 0 ), "[Warning] ", CLIENT and Color( 255, 222, 102 ) or Color( 137, 222, 255 ), CLIENT and "Client: " or "Server: ", color_white, "Overwriting net ", id, "\n" )
    end

    events[ id ] = callback
end

net.Receive( "LuaComputers", function( len, ply )
    local id = net.ReadInt( 8 )

    if not events[ id ] then return end

    local data = net.ReadData( len - 8 )
    local args = util.JSONToTable( util.Decompress( data ) ) or {}

    if SERVER then
        events[ id ]( ply, unpack( args ) )
    else
        events[ id ]( unpack( args ) )
    end
end )

--  > Initializing names
LuaComputers.AddNetwork( "RunString" )
LuaComputers.AddNetwork( "RunFile" )