LuaComputers = {
    version = "0.0.1"
}

local function add_resources( path )
    local files, folders = file.Find( path .. "*", "GAME" )

    for k, v in ipairs( files ) do
        resource.AddFile( path .. v )
    end

    for k, v in ipairs( folders ) do
        add_resources( path .. v .. "/" )
    end
end

add_resources( "resource/fonts/JetBrainsMono" )
add_resources( "materials/lua_computers/" )

local function include_cl( path )
    if SERVER then
        AddCSLuaFile( path )
    else
        include( path )
    end
end

local function include_sv( path )
    if SERVER then
        include( path )
    end
end

local function include_sh( path )
    AddCSLuaFile( path )
    include( path )
end

include_cl( "lua_computers/cl_fonts.lua" )
include_sh( "lua_computers/sh_networking.lua" )
include_sh( "lua_computers/sh_environments.lua" )
include_sh( "lua_computers/sh_loader.lua" )
include_sh( "lua_computers/sh_terminal.lua" )
include_cl( "lua_computers/cl_terminal.lua" )
include_sh( "lua_computers/environments/basic_computer.lua" )