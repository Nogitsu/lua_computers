ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Computer"
ENT.Category = "LuaComputers"
ENT.Spawnable = true

ENT.LuaComputerType = "Computer"

LuaComputers.AddNetwork( "OpenComputer" )

function ENT:StartComputer( tbl )
	local id = self:EntIndex()
    LuaComputers.coroutines[id] = LuaComputers.RunFile( "startup.lua", "BasicComputer", nil, id )
    LuaComputers.coroutines[LuaComputers.coroutines[id]] = tbl or {}
end