Texture    = smaug.java.require "com.badlogic.gdx.graphics.Texture"
Constants = smaug.java.require "smaug.wrappers"

class
  new: (path, format = "rgba8", f_type) =>
    file = smaug.File path, f_type

    @texture = smaug.java.new Texture, file.file, Constants.formats[format], false
    @texture\setFilter Constants.filters["linear"], Constants.filters["linear"]

  get_dimensions: =>
    @get_width!, @get_height!

  get_filter: =>
    min_filter = @texture\getMinFilter!
    mag_filter = @texture\getMagFilter!

    Constants.filter_codes[min_filter], Constants.filter_codes[mag_filter]

  get_format: =>
    texture_data = @texture\getTextureData!
    format       = texture_data\getFormat!

    Constants.format_codes[format]

  get_width: =>
    @texture\get_width

  get_height: =>
    @texture\getHeight!

  get_wrap: =>
    Constants.wraps[@texture\getUWrap!], Constants.wraps[@texture\getVWrap!]

  set_filter: (min, mag) =>
    @texture\setFilter Constants.filters[min], Constants.filters[mag]

  set_wrap: (h, v) =>
    @texture\setWrap Constants.wraps[h], Constants.wraps[v]

  dispose: =>
    @texture\dispose!
