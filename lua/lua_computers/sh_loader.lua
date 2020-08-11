LuaComputers.coroutines = {}

LuaComputers.AddNetwork( "RunString" )
LuaComputers.AddNetwork( "RunFile" )

function LuaComputers.RunString( code, env, id, ... )
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

    --  > Start coroutine
    local thread = coroutine.create( func )
    local success, err = coroutine.resume( thread, ... )
    if not success then
        LuaComputers.Error( "Error:", err )
        return
    end

    return thread
end

function LuaComputers.RunDefaultFile( path, env, id, ... )
    if not file.Exists( "lua_computers/defaults/" .. path, "LUA" ) then return end

    return LuaComputers.RunString( file.Read( "lua_computers/defaults/" .. path, "LUA" ), env, id or path, ... )
end

function LuaComputers.RunFile( path, env, id, ... )
    if not file.Exists( "lua_computers/" .. path, "DATA" ) then
        return assert( LuaComputers.RunDefaultFile( path, env, id ), "File " .. path .. " not found." )
    end

    return LuaComputers.RunString( file.Read( "lua_computers/" .. path ), env, id or path, ... )
end

if SERVER then
    LuaComputers.OnNetwork( "RunString", function( ply, code, env, ... )
        LuaComputers.RunString( code, env, "LuaTerminal", ... )
    end )

    LuaComputers.OnNetwork( "RunFile", function( ply, path, env, ... )
        LuaComputers.RunFile( path, env, path, ... )
    end )
else
    LuaComputers.OnNetwork( "RunString", function( code, env, ... )
        LuaComputers.RunString( code, env, "LuaTerminal", ... )
    end )

    LuaComputers.OnNetwork( "RunFile", function( path, env, ... )
        LuaComputers.RunFile( path, env, path, ... )
    end )
end