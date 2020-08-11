include( "shared.lua" )

local scale = 0.4
ENT.FrameSize = {
    w = ScrW() * scale, h = ScrW() * scale
}

function ENT:ScaleToSize( value, original_size, frame_size )
    return math.ceil( value * frame_size / original_size )
end

function ENT:Initialize()
    local horizontal = self:ScaleToSize( 31, 512, self.FrameSize.w )
    local vertical = self:ScaleToSize( 31, 512, self.FrameSize.h )

    self.Padding = {
        left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical,
    }
end

local mat = Material( "lua_computers/overlays/basic_computer.png" )
function ENT:OpenComputer()
    local frame = vgui.Create( "DFrame" )
    frame:DockPadding( self.Padding.left, self.Padding.top, self.Padding.right, self.Padding.bottom )
    frame:SetSize( self.FrameSize.w, self.FrameSize.h )
    frame:Center()
    frame:SetTitle( "" )
    frame:SetDraggable( false )
    frame:MakePopup()
    function frame:Paint( w, h )
        surface.SetMaterial( mat )
        surface.SetDrawColor( color_white )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local screen_panel = frame:Add( "DPanel" )
    screen_panel:Dock( FILL )
    screen_panel:SetBackgroundColor( Color( 12, 12, 12 ) )
    screen_panel:RequestFocus()
    function screen_panel:Paint( w, h )
        surface.SetDrawColor( self:GetBackgroundColor() )
        surface.DrawRect( 0, 0, w, h )
    end
    function screen_panel:OnKeyCodePressed( code )
        print( "Press: ",  code, input.GetKeyName( code ) )
    end
    function screen_panel:OnKeyCodeReleased( code )
        if code == KEY_ESCAPE then
            frame:Remove()
            gui.HideGameUI()
        end
        print( "Release: ",  code, input.GetKeyName( code ) )
    end
end

LuaComputers.OnNetwork( "OpenComputer", function( ent )
	ent = Entity( ent )

    if not IsValid( ent ) then return end

    if not ent.LuaComputerType then return end
    if ent.LuaComputerType ~= "Computer" then return end


    ent:OpenComputer()
end )