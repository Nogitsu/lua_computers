function LuaComputers.OpenTerminal()
    if not IsValid( LuaComputers.terminal ) then
        local frame = vgui.Create( "DFrame" )
        frame:SetSize( ScrW() * 0.5, ScrH() * 0.8 )
        frame:Center()
        frame:MakePopup()
        frame:SetTitle( "LuaComputer's Terminal" )
        frame:SetDeleteOnClose( false )

        LuaComputers.terminal = frame

        local console = frame:Add( "RichText" )
        console:Dock( FILL )
        function console:PerformLayout()
            self:SetBGColor( 77, 79, 82, 255 )
            self:SetFontInternal( "LuaTerminalFont" )
        end

        LuaComputers.terminal.console = console

        local bottom = frame:Add( "EditablePanel" )
        bottom:Dock( BOTTOM )
        bottom:DockMargin( 0, 5, 0, 0 )

        local entry = bottom:Add( "DTextEntry" )
        entry:Dock( FILL )
        timer.Simple( 0, function() entry:RequestFocus() end )

        local submit = bottom:Add( "DButton" )
        submit:Dock( RIGHT )
        submit:DockMargin( 5, 0, 0, 0 )
        submit:SetText( "Submit" )
        function submit:DoClick()
            --LuaComputers.CallNetwork( "RunString", entry:GetValue(), "terminal" )
            LuaComputers.RunString( entry:GetValue(), "terminal", "LuaTerminal" )
        end
        function entry:OnEnter()
            submit:DoClick()
            self:RequestFocus()
        end
    else
        LuaComputers.terminal:Show()
        LuaComputers.terminal:MakePopup()
    end
end

concommand.Add( "lc_terminal", LuaComputers.OpenTerminal )
concommand.Add( "lc_terminal_reload", function()
    if not IsValid( LuaComputers.terminal ) then return end

    local visible = LuaComputers.terminal:IsVisible()
    LuaComputers.terminal:Remove()

    if visible then
        LuaComputers.OpenTerminal()
    end
end )