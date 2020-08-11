local env_name = "BasicComputer"

local os = LuaComputers.IncludeForEnvironment( env_name, "os.lua" )
local colors = LuaComputers.IncludeForEnvironment( env_name, "colors.lua" )
local term = LuaComputers.IncludeForEnvironment( env_name, "term.lua" )

LuaComputers.AddEnvironment( env_name, {
    print = LuaComputers.Print,
    error = LuaComputers.Error,
    math = math,
    --  > Standard
    os = os,
    --  > Graphics
    colors = colors,
    term = term,
} )