import java from smaug

TimeUtils = java.require "com.badlogic.gdx.utils.TimeUtils"
Gdx       = java.require "com.badlogic.gdx.Gdx"
Thread    = java.require "java.lang.Thread"

get_delta = ->
  Gdx.graphics\getDeltaTime!

get_fps = ->
  Gdx.graphics\getFramesPerSecond!

get_time = ->
  TimeUtils\millis!

sleep = (ms) ->
  Thread\sleep ms

{
  :get_delta
  :get_fps
  :get_time
  :sleep
}
