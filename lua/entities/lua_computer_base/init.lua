AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua")

function ENT:Initialize()
	self:SetModel( "models/props_lab/monitor02.mdl" )
	
    self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetUseType( SIMPLE_USE )
end

function ENT:Use( ply )
	LuaComputers.CallNetwork( "OpenComputer", ply, self:EntIndex() )
	self:StartComputer()
end

function ENT:StartComputer()
	local id = self:EntIndex()
	LuaComputers.coroutines[id] = LuaComputers.RunFile( "startup.lua", "BasicComputer", nil, id )
end