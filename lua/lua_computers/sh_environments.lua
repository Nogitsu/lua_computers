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

function LuaComputers.IncludeForEnvironment( env_name, path )
    path = "lua_computers/environments/" .. env_name:lower() .. "/" .. path

    if SERVER then
        AddCSLuaFile( path )
    end

    return include( path )
end