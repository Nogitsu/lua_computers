function LuaComputers.RunString( code, env, id )
    if not code then return end

    local func = CompileString( code, id or "LuaComputers", false )
    print( func )

    print( "Running code:" )
    print( code )

    if not isfunction( func ) then
        if isstring( func ) then
            print( "LuaComputers error:", func )
        end
        return
    end

    --  > Set the environment and call our code
    debug.setfenv( func, env or {} )

    local success, err = pcall( func )

    if not success then
        print( "LuaComputers error:", err )
    end
end

function LuaComputers.RunFile( path, env, id )
    if not file.Exists( "lua_computers/" .. path, "DATA" ) then return error( "File " .. path .. " not found." ) end

    LuaComputers.RunString( file.Read( "lua_computers/" .. path ), env, id )
end

LuaComputers.OnNetwork( "RunString", function( ply, code, env )
    LuaComputers.RunString( code, LuaComputers.GetEnvironment( env ), "LuaTerminal" )
end )

LuaComputers.OnNetwork( "RunFile", function( ply, path )
    LuaComputers.RunFile( path, LuaComputers.GetEnvironment, path )
end )