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

function LuaComputers.RunFile( path )
    if not file.Exists( "lua_computers/" .. path, "DATA" ) then return error( "File " .. path .. " not found." ) end

    LuaComputers.RunString( file.Read( "lua_computers/" .. path ) )
end

LuaComputers.OnNetwork( "RunString", function( ply, code )
    LuaComputers.RunString( code, nil, "LuaTerminal" )
end )

LuaComputers.OnNetwork( "RunFile", function( ply, path )
    LuaComputers.RunFile( path )
end )