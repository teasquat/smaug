import java from smaug

Gdx     = java.require "com.badlogic.gdx.Gdx"
SmaugVM = java.require "smaug.SmaugVM"

get_clipboard = ->
  Gdx.app\getClipboard!\getContents!

set_clipboard = (v) ->
  Gdx.app\getClipboard!\setContents v

get_os = ->
  SmaugVM.util\get_OS!

get_memory = ->
  Gdx.app\getJavaHeap!

open_url = (url) ->
  Gdx.net\openURI url

vibrate = (ms) ->
  Gdx.input\vibrate ms

quit = ->
  Gdx.app\exit!

{
  :get_clipboard
  :get_os
  :get_memory
  :open_url
  :set_clipboard
  :vibrate
  :quit
}
