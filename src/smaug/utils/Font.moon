FreeTypeFontGenerator = smaug.java.require "com.badlogic.gdx.graphics.g2d.freetype.FreeTypeFontGenerator"
GlyphLayout           = smaug.java.require "com.badlogic.gdx.graphics.g2d.GlyphLayout"

Constants = require "smaug.wrappers"

class
  new: (path, size = 16, f_type) =>
    local file

    unless path
      file = smaug.File ".smaug/font.tff", f_type
    else
      file = smaug.File path, f_type

    generator = smaug.java.new FreeTypeFontGenerator, file.file

    @font = generator\generateFont size

    @font_texture = (@font\getRegion 0)\getTexture!
    @font_texture\setFilter Constants.filters["linear"], Constants.filters["linear"]

    @glyph_layout = smaug.java.new GlyphLayout

  get_ascent: =>
    @font\getAscent!

  get_descent: =>
    @font\getDescent!

  get_line_height: =>
    @font\getLineHeight!

  get_bounds: (text) =>
    @glyph_layout\setText text
    @glyph_layout.width, @glyph_layout.height

  get_filter: =>
    min_filter = @font_texture\getMinFilter!
    mag_filter = @font_texture\getMagFilter!

    Constants.filters[min_filter], Constants.filters[mag_filter]

  get_width: (text) =>
    w, _ = @get_bounds text
    w

  get_height: (text) =>
    _, h = @get_bounds text
    h

  has_glyphs: (...) =>
    args  = table.pack ...
    found = true

    for i = 1, args.n
      found = found and @font\containsCharacter args[i]
    found

  set_filter: (min, mag) =>
    @font_texture\setFilter Constants.filters[min], Constants.filters[mag]

  set_line_height: (height) =>
    @font\getData!\setLineHeight height

  dispose: =>
    @font\dispose!
