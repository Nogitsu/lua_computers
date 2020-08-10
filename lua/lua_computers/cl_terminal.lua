function LuaComputers.OpenTerminal()
    if not IsValid( LuaComputers.terminal ) then
        local frame = vgui.Create( "DFrame" )
        frame:SetSize( ScrW() * 0.5, ScrH() * 0.8 )
        frame:Center()
        frame:MakePopup()
        frame:SetTitle( "LuaComputer's Terminal" )

        LuaComputers.terminal = frame

        local console = frame:Add( "RichText" )
        console:Dock( FILL )

        LuaComputers.terminal.console = console

        local bottom = frame:Add( "EditablePanel" )
        bottom:Dock( BOTTOM )

        local entry = bottom:Add( "DTextEntry" )
        entry:Dock( FILL )

        local submit = bottom:Add( "DButton" )
        submit:Dock( RIGHT )
        submit:DockMargin( 5, 0, 0, 0 )
        submit:SetText( "Submit" )
        function submit:DoClick()
            --LuaComputers.CallNetwork( "RunString", "print( 'Hello world !' )", "terminal" )
            LuaComputers.Print( "Hello world !" )
        end
    else
        LuaComputers.terminal:Show()
        LuaComputers.terminal:MakePopup()
    end
end

concommand.Add( "lc_terminal", LuaComputers.OpenTerminal )