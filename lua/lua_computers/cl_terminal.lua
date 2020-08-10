function LuaComputers.OpenTerminal()
    local frame = vgui.Create( "DFrame" )
    frame:SetSize( ScrW() * 0.9, ScrH() * 0.9 )
    frame:Center()
    frame:MakePopup()

    local ide = frame:Add( "DTextEntry" )
    ide:Dock( FILL )
    ide:SetMultiline( true )
    ide:RequestFocus()

    local exec = frame:Add( "DButton" )
    exec:Dock( BOTTOM )
    exec:SetText( "Execute" )
    function exec:DoClick()
        LuaComputers.CallNetwork( "RunString", ide:GetValue() )
    end
end

concommand.Add( "lc_terminal", LuaComputers.OpenTerminal )