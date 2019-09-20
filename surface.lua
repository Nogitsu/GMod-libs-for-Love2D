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
  text_r = r or 255
  text_g = g or 255
  text_b = b or 255
  text_a = a or 255
end

function surface.GetDrawColor()
  return draw_r, draw_g, draw_b, draw_a
end

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
  love.graphics.draw( next_draw, x, y, 0, w/iw, h/ih )
end

function surface.DrawTexturedRectRotated( x, y, w, h, ang )
  local iw, ih = next_draw:getDimensions()
  love.graphics.draw( next_draw, x + w/2, y + h/2, ang, w/iw, h/ih, iw/2, ih/2 )
end

--  > Rectangles
function surface.DrawRect( x, y, w, h )
  love.graphics.rectangle( "fill", x, y, w, h )
end

function surface.DrawOutlinedRect( x, y, w, h )
  love.graphics.rectangle( "line", x, y, w, h )
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
  text_x = x
  text_y = y
end

function surface.SetTextColor( r, g ,b, a )
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
