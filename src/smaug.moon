-- type checking for classes
_type = type
export type = (v) ->
  base = _type v
  if base == "table"
    cls = v.__class
    return cls.__name if cls
  base

smaug.console = require "smaug.console"
smaug.java    = require "smaug.java"

smaug.File    = require "smaug.dep.File"

smaug.file_system = require "smaug.file_system"

smaug.run = ->
  dt = smaug.timer.get_delta!

  smaug.update(dt) if smaug.update

  smaug.graphics.clear!
  smaug.graphics.origin!

  smaug.draw! if smaug.draw

  smaug.graphics.present!

require "main"