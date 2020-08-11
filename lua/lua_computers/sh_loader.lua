function LuaComputers.RunString( code, env, id )
    assert( code, "No code was found" )

    local func = CompileString( code, id or "LuaComputers", false )

    if not isfunction( func ) then
        if isstring( func ) then
            LuaComputers.Error( "Error:", func )
        end
        return
    end

    --  > Set the environment and call our code
    env = table.Copy( istable( env ) and env or LuaComputers.GetEnvironment( env ) or {} )
    debug.setfenv( func, env )

    local success, err = pcall( coroutine.wrap( func ) )
    if not success then
        LuaComputers.Error( "Error:", err )
    end
end

function LuaComputers.RunDefaultFile( path, env, id )
    if not file.Exists( "lua_computers/defaults/" .. path, "LUA" ) then return false end

    LuaComputers.RunString( file.Read( "lua_computers/defaults/" .. path, "LUA" ), env, id )

    return true
end

function LuaComputers.RunFile( path, env, id )
    if not file.Exists( "lua_computers/" .. path, "DATA" ) then
        return assert( LuaComputers.RunDefaultFile( path, env, id ), "File " .. path .. " not found." )
    end

    LuaComputers.RunString( file.Read( "lua_computers/" .. path ), env, id )
end

if SERVER then
    LuaComputers.OnNetwork( "RunString", function( ply, code, env )
        LuaComputers.RunString( code, env, "LuaTerminal" )
    end )

    LuaComputers.OnNetwork( "RunFile", function( ply, path, env )
        LuaComputers.RunFile( path, env, path )
    end )
else
    LuaComputers.OnNetwork( "RunString", function( code, env )
        LuaComputers.RunString( code, env, "LuaTerminal" )
    end )

    LuaComputers.OnNetwork( "RunFile", function( path, env )
        LuaComputers.RunFile( path, env, path )
    end )
end