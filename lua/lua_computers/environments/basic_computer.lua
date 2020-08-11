local env_name = "BasicComputer"

LuaComputers.AddEnvironment( env_name, {
    os = LuaComputers.IncludeForEnvironment( env_name, "lua_computers" ),
} )