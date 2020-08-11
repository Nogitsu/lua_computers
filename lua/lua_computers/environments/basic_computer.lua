local env_name = "BasicComputer"

LuaComputers.AddEnvironment( env_name, {
    print = LuaComputers.Print,
    os = LuaComputers.IncludeForEnvironment( env_name, "os.lua" ),
} )