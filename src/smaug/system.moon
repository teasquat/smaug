import java from smaug

Gdx     = java.require "com.badlogic.gdx.Gdx"
SmaugVM = java.require "smaug.SmaugVM"

get_clipboard = ->
  clipboard = Gdx.app\getClipboard!
  clipboard\getContents!

get_os = ->
  SmaugVM.util\get_OS!

get_memory_info = ->
  Gdx.app\getJavaHeap!
