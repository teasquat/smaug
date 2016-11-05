import java, Font, Image, Quad from smaug

Constants = require "smaug/wrappers"
Color     = java.require "com.badlogic.gdx.graphics.Color"
Gdx       = java.require "com.badlogic.gdx.Gdx"
GL20      = java.require "com.badlogic.gdx.graphics.GL20"
Matrix4   = java.require "com.badlogic.gdx.math.Matrix4"
SmaugVM   = java.require "smaug.SmaugVM"

OrthographicCamera = java.require "com.badlogic.gdx.graphics.OrthographicCamera"
ShapeRender        = java.require "com.badlogic.gdx.graphics.glutils.ShapeRender"
SpriteBatch        = java.require "com.badlogic.gdx.graphics.g2d.SpriteBatch"

shader = SpriteBatch\createDefaultShader!

batch  = java.new SpriteBatch, 1000, shader
shapes = java.new ShapeRender

font = Font!

shapes\setAutoShapeType true

matrix = java.new Matrix4
color  = java.new Color, 1, 1, 1, 1

background = java.new Color 0, 0, 0, 1
blending   = "alphas"

batch\setColor color
shapes\setColor color
font.font\setColor color

camera = java.new OrthographicCamera
camera\setToOrtho true

batch\setProjectionMatrix camera.combined
shapes\setProjectionMatrix camera.combined

matrix_dirty = false

check = (texture_based) ->
  if texture_based
    if matrix_dirty
      batch\setTransformMatrix matrix
      matrix_dirty = false

    if shapes\isDrawing!
      SmaugVM.util\endShapes shapes
    unless batch\isDrawing!
      batch\begin!
  else
    if matrix_dirty
      shapes\setTransformMatrix matrix
      matrix_dirty = false

    if batch\isDrawing!
      SmaugVM.util\endBatch batch
    unless shapes\isDrawing!
      shapes\begin!

arc = (mode, x, y, radius, a1, a2) ->
  check false

  shapes\set Constants.shapes[mode]
  shapes\arc x, y, radius, (math.deg a1), math.deg a2

circle = (mode, x, y, radius) ->
  check false

  shapes\set Constants.shapes[mode]
  shapes\circle x, y, radius

clear = ->
  Gdx.gl\glClearColor background.r, background.g, background.b
  Gdx.gl\glClear GL20.GL_COLOR_BUFFER_BIT

draw = (image, x = 0, y = 0, r = 0, sx = 1, sy = 1, ox = 0, oy = 0) ->
  check true

  w = image\getWidth!
  h = image\getHeight!

  src_x = 0
  src_y = 0

  src_w = w
  src_h = h

  x -= ox
  y -= oy

  batch\draw image.texture, x, y, ox, oy, w, h, sx, sy, r, srx_x, srx_y, src_w, src_h, false, true

draw_q = (image, quad, x = 0, y = 0, r = 0, sx = 1, sy = 1, ox = 0, oy = 0) ->
  check true

  w = quad.width
  h = quad.height

  src_x = quad.x
  src_y = quad.y

  src_w = quad.sw
  src_h = quad.sh

  x -= ox
  y -= oy

  batch\draw image.texture, x, y, ox, oy, w, h, sx, sy, r, src_x, src_y, src_w, src_h, false, true

ellipse = (mode, x, y, width, height) ->
  check false

  shapes\set Constants.shapes[mode]
  shapes\ellipse x, y, width, height

line = (x1, y1, x2, y2) ->
  check false
  shapes\line x1, y1, x2, y2

origin = ->
  matrix\idt!
  matrix_dirty = true

point = (x, y) ->
  check false
  shapes\point x, y, 0

polygon = (mode, ...) ->
  check false
  shapes\set Constants.shapes[mode]

  args = table.pack ...

  if type args[1] == "table"
    shapes\polygon args[1]
  else
    shapes\polygon args

present = ->
  if shapes\isDrawing!
    SmaugVM.util\endShapes shapes
  if batch\isDrawing!
    SmaugVM.util\endBatch batch

print = (text, x = 0, y = 0, r = 0, sx = 1, sy = 1, ox = 0, oy = 0) ->
  check true

  local tmp

  unless r == 0
    tmp = batch\getTransformMatrix!
    translate x, y
    rotate r
    translate -x, -y

    batch\setTransformMatrix matrix
    matrix_dirty = false

  font.font\getData!\setScale sx, sy
  font.font\draw batch, text, x - ox * sx, y - oy * sy

  unless r == 0
    translate x, y
    rotate -r
    translate -x, -y

    batch\setTransformMatrix tmp
    matrix_dirty = false

prin_f = (text, width = 0, align = "left", x = 0, y = 0, r = 0, sx = 1, sy = 1, ox = 0, oy = 0) ->
  check true

  tmp = nil

  unless r == 0
    tmp = batch\getTransformMatrix!
    translate x, y
    rotate r
    translate -x, -y

    batch\setTransformMatrix matrix
    matrix_dirty = false

  font.font\getData!\setScale sx, -sy
  font.font\draw batch, text, x - ox * sx, y - oy * sy, width, Constants.aligns[align], true

  unless r == 0
    translate x, y
    rotate -r
    translate -x, -y

    batch\setTransformMatrix tmp
    matrix_dirty = false

rectangle = (mode, x, y, width, height) ->
  check false

  shapes\set Constants.shapes[mode]
  shapes\rect x, y, width, height

reset = ->
  shader = SpriteBatch\createDefaultShader!
  batch\setShader shader

  background\set 0.4, 0.3, 0.4, 1
  color\set 1, 1, 1, 1

  batch\setColor color
  shapes\setColor color
  font.font\setColor color

  matrix\idt!
  matrix_dirty = true

translate = (x, y) ->
  matrix\translate x, y
  matrix_dirty = true

rotate = (radians) ->
  matrix\rotate 0, 0, 1, math.deg radians
  matrix_dirty = true

scale = (sx, sy) ->
  matrix\scale sx, sy, 1
  matrix_dirty = true

get_background_color = ->
  background.r * 255, background.g * 255, background.b * 255

get_blend_mode = ->
  blending

get_color = ->
  color.r * 255, color.g * 255, color.b * 255, color.a * 255

get_font = ->
  font

set_background_color = (r, g, b, a = 255) ->
  background\set r / 255, g / 255, b / 255, a / 255

set_blend_mode = (mode) ->
  blending = mode

  blend_mode = Constants[blending]
  batch\setBlendFunction blend_mode[1], blend_mode[2]

set_font = (v) ->
  font = v

set_new_font = (path, size, f_type) ->
  font = new_font path, size, f_type

new_font = (path, size, f_type) ->
  (Font path, size, f_type)

new_image = (path, format, f_type) ->
  (Image path, format, f_type)

new_quad = (x, y, width, height, sx, sy) ->
  (Quad x, y, width, height, sx, sy)

{
  :arc
  :circle
  :clear
  :draw
  :draw_q
  :ellipse
  :get_background_color
  :get_blendMode
  :get_color
  :get_font
  :line
  :origin
  :point
  :polygon
  :present
  :print
  :print_f
  :rectangle
  :reset
  :translate
  :rotate
  :scale
  :set_background_color
  :set_blend_mode
  :set_color
  :set_font
  :set_new_font
  :new_font
  :new_image
  :new_quad
}
