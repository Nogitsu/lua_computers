local env_name = "BasicComputer"

LuaComputers.AddEnvironment( env_name, {
    print = LuaComputers.Print,
    error = LuaComputers.Error,

    os = LuaComputers.IncludeForEnvironment( env_name, "os.lua" ),

    colors = LuaComputers.IncludeForEnvironment( env_name, "colors.lua" ),
    term = LuaComputers.IncludeForEnvironment( env_name, "term.lua" ),
} )