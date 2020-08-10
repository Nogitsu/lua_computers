LuaComputers = {}

local function add_resources( path )
    local files, folders = file.Find( path .. "/*", "GAME" )

    for k, v in ipairs( files ) do
        resource.AddFile( path .. "/" .. v )
    end

    for k, v in ipairs( folders ) do
        add_resources( path .. "/" .. v )
    end
end

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

include_sh( "lua_computers/sh_networking.lua" )
include_sv( "lua_computers/sv_loader.lua" )
include_cl( "lua_computers/cl_terminal.lua" )