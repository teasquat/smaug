-- type checking for classes
_type = type
export type = (v) ->
  base = _type v
  if base == "table"
    cls = v.__class
    return cls.__name if cls
  base

smaug.console = require "smaug/core/console"
smaug.java    = require "smaug/core/java"

smaug.File    = require "smaug/utils/File"
smaug.Font    = require "smaug/utils/Font"
smaug.Image   = require "smaug/utils/Image"
smaug.Quad    = require "smaug/utils/Quad"

smaug.file_system = require "smaug/core/file_system"
smaug.timer       = require "smaug/core/timer"
smaug.graphics    = require "smaug/core/graphics"

smaug.run = ->
  dt = smaug.timer.get_delta!

  smaug.update(dt) if smaug.update

  smaug.graphics.clear!
  smaug.graphics.origin!

  smaug.draw! if smaug.draw

  smaug.graphics.present!

require "main"
