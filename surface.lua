surface = {}

--  > Screen size getters
function ScrW()
  return love.graphics.getWidth()
end

function ScrH()
  return love.graphics.getHeight()
end

--  > Color funcs
local draw_r, draw_g, draw_b, draw_a = 255, 255, 255, 255
function surface.SetDrawColor( r, g, b, a )
  if type( r ) == "table" then
    surface.SetDrawColor( r.r, r.g, r.b, r.a )
  return end

  draw_r = r or 255
  draw_g = g or 255
  draw_b = b or 255
  draw_a = a or 255

  love.graphics.setColor( draw_r / 255, draw_g / 255, draw_b / 255, draw_a / 255 )
end

function surface.GetDrawColor()
  return { r = draw_r, g = draw_g, b = draw_b, a = draw_a }
end

function surface.Background( r, g ,b )
  if type( r ) == "table" then
    surface.Background( r.r, r.g, r.b )
  return end

  love.graphics.setBackgroundColor( r / 255, g / 255, b / 255 )
end

function Color( r, g, b, a )
  return { r = r or 255, g = g or 255, b = b or 255, a = a or 255 }
end
rgb = Color

color_white = Color( 255, 255, 255 )

--  > Line
function surface.DrawLine( sX, sY, eX, eY )
  love.graphics.line( sX, sY, eX, eY )
end

--  > Textured
function Material( path )
  return love.graphics.newImage( path )
end

local next_draw
function surface.SetMaterial( mat )
  next_draw = mat
end

function surface.DrawTexturedRect( x, y, w, h )
  local iw, ih = next_draw:getDimensions()
  love.graphics.draw( next_draw, x, y, 0, w / iw, h / ih )
end

function surface.DrawTexturedRectRotated( x, y, w, h, ang )
  local iw, ih = next_draw:getDimensions()
  love.graphics.draw( next_draw, x + w / 2, y + h / 2, ang, w / iw, h / ih, iw / 2, ih / 2 )
end

--  > Rectangles
function surface.DrawRect( x, y, w, h )
  love.graphics.rectangle( "fill", x, y, w, h )
end

function surface.DrawPixel( x, y )
  surface.DrawRect( x, y, 1, 1 )
end

function surface.DrawOutlinedRect( x, y, w, h )
  love.graphics.rectangle( "line", x, y, w, h )
end

--   > Poly
function surface.DrawPoly( ... )
  love.graphics.polygon( "fill", ... )
end

function surface.DrawCircle( x, y, radius, angle_start, angle_end )
    local poly = {}
    table.insert( poly, { x = x, y = y } )

    for i = math.min( angle_start or 0, angle_end or 360 ), math.max( angle_start or 0, angle_end or 360 ) do
        local a = math.rad( i )
        if ( angle_start or 0 ) < 0 then
            table.insert( poly, { x = x + math.cos( a ) * radius, y = y + math.sin( a ) * radius } )
        else
            table.insert( poly, { x = x - math.cos( a ) * radius, y = y - math.sin( a ) * radius } )
        end
    end
    table.insert( poly, { x = x, y = y } )

    surface.DrawPoly( poly )

    return poly
end

function surface.DrawElipse( x, y, w, h )
    surface.DrawCircle( x + h / 2, y + h / 2 + (y == 0 and 0 or - .5), h / 2, 90, -90 )
    surface.DrawCircle( x + w - h / 2, y + h / 2 + (y == 0 and 0 or - .5), h / 2, -90, 90 )

    surface.DrawRect( x + h / 2, y - 1, w - h + 2, h + 1 )
end

--  > Fonts
local fonts = {}

function surface.CreateFont( name, settings )
  fonts[ name ] = love.graphics.newFont( settings.font, settings.size )
end

function surface.SetFont( name )
  love.graphics.setFont( fonts[ name ] )
end

--  > Text
local text_x, text_y, text_r, text_g, text_b, text_a = 0, 0, 255, 255, 255, 255
function surface.SetTextPos( x, y )
  text_x = math.ceil( x )
  text_y = math.ceil( y )
end

function surface.SetTextColor( r, g ,b, a )
  if type( r ) == "table" then
    surface.SetTextColor( r.r, r.g, r.b, r.a )
  return end

  text_r = r or 255
  text_g = g or 255
  text_b = b or 255
  text_a = a or 255
end

function surface.DrawText( text )
  love.graphics.setColor( text_r / 255, text_g / 255, text_b / 255, text_a / 255 )
  love.graphics.print( text, text_x, text_y )
  love.graphics.setColor( draw_r / 255, draw_g / 255, draw_b / 255, draw_a / 255 )
end

local templab
function surface.GetTextSize( text )
  templab = templab or love.graphics.newText( love.graphics.getFont(), "" )
  templab:setFont( love.graphics.getFont() )
  templab:set( text )

  return templab:getDimensions()
end

--  > Custom
function Lerp( delta, from, to )

	if ( delta > 1 ) then return to end
	if ( delta < 0 ) then return from end

	return from + ( to - from ) * delta

end

function LerpColor( t, c1, c2 )
    return Color( Lerp( t, c1.r, c2.r ), Lerp( t, c1.g, c2.g ), Lerp( t, c1.b, c2.b ), c1.a == c2.a and c1.a or Lerp( t, c1.a, c2.a ) )
end

function surface.DrawGradient( x, y, w, h, color1, color2, vertical )
    vertical = vertical or false

    if not vertical then
        for i = 0, w do
            surface.SetDrawColor( LerpColor( i / w, color1, color2 ) )
            surface.DrawLine( x + i, y, x + i, y + h )
        end
    else
        for i = 0, h do
            surface.SetDrawColor( LerpColor( i / h, color1, color2 ) )
            surface.DrawLine( x, y + i, x + w, y + i )
        end
    end
end