local term = {
    _pos = {
        column = 0,
        line = 0,
    },
    _font = "LuaTerminalFont",
    _space = {
        x = 0,
        y = 0,
    },
    _text_color = color_white,
}

if CLIENT then
    surface.SetFont( term._font )
    term._space.x, term._space.y = surface.GetTextSize( "A" )
    print( term._space.x, term._space.y )
end

function term.write( text )
    local infos = LuaComputers.coroutines[coroutine.running()]

    local column, line, color = term._pos.column, term._pos.line, term._text_color
    infos.draw_funcs[#infos.draw_funcs + 1] = function( w, h )
        draw.SimpleText( text, term._font, column * term._space.x, line * term._space.y, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    end
end

function term.clear()
end

function term.clearLine()
end

function term.setCursorPos( x, y )
    term._pos.column = x
    term._pos.line = y
end

function term.getCursorPos()
    return term._pos.column, term._pos.line
end

function term.setCursorBlink( bool )
end

function term.isColor()
    return false
end

function term.getSize()
end

function term.scroll( n )
end

function term.redirect( target )
end

function term.current()
end

function term.native()
end

function term.setTextColor( r, g, b )
    term._text_color = Color( r, g, b )
    print( "new color!", term._text_color )
end

function term.getTextColor()
    return term._text_color
end

function term.setBackgroundColor( r, g, b )
end

function term.getBackgroundColor()
end

return term