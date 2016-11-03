import java, File from smaug

Gdx     = java.require "com.badlogic.gdx.Gdx"
SmaugVM = java.require "smaug.SmaugVM"

append = (path, v, t) ->
  file = new_file path, t
  file\append v

copy = (old, new, old_t, new_t) ->
  old_f = new_file old, old_t
  new_f = new_file new, new_t

  old_f\copy new_f

exists = (f, t) ->
  file = new_file f, t
  file\exists!

dir_create = (f, t) ->
  file = new_file f, t
  file\create_dir!

dir_list = (f, t) ->
  file = new_file f, t
  file\list!

get_external_path = ->
  Gdx.files\getLocalStoragePath!

get_working_path = ->
  file = new_file(".")\file!
  file\getAbsolutePath!

get_last_modified = (f, t) ->
  file = new_file f, t
  file\last_modified!

get_size = (f, t) ->
  file = new_file f, t
  file\size!

is_dir = (f, t) ->
  file = new_file f, t
  file\is_directory!

is_file = (f, t) ->
  file = new_file f, t
  file\is_file!

load = (f, t) ->
  file = new_file f, t
  SmaugVM.lua\load file\reader!, file

move = (old, new, old_t, new_t) ->
  old_f = new_file old, old_t
  new_f = new_file new, new_t

  old_f\move new_f

new_file = (f, t) ->
  File f, t

read = (f, t) ->
  file = new_file f, t
  file\read!

remove = (f, t) ->
  file = new_file f, t
  file\remove!

write = (f, v, t) ->
  file = new_file f, t
  file\write v

{
  :append
  :copy
  :exists
  :dir_create
  :dir_list
  :get_external_path
  :get_working_path
  :get_last_modified
  :get_size
  :load
  :move
  :new_file
  :read
  :remove
  :write
}
