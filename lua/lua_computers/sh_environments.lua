LuaComputers.environments = {}

function LuaComputers.AddEnvironment( name, env )
    LuaComputers.environments[ name ] = env
end

function LuaComputers.GetEnvironment( name )
    return LuaComputers.environments[ name ]
end

function LuaComputers.AddEnvironmentValue( env_name, name, value )
    if not LuaComputers.environments[ name ] then return end

    LuaComputers.environments[ env_name ][ name ] = value
end