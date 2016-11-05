path = "smaug/wrappers/"

aligns      = require path .. "aligns"
blend_modes = require path .. "blend_modes"
filters     = require path .. "filters"
formats     = require path .. "formats"
keys        = require path .. "key_codes"
buttons     = require path .. "mouse"
shapes      = require path .. "shapes"
wraps       = require path .. "texture_wrapping"

key_codes = {}
for k, v in pairs key_codes
  key_codes[v] = k

button_codes = {}
for k, v in pairs buttons
  button_codes[v] = k

format_codes = {}
for k, v in pairs formats
  format_codes[v] = k

wrap_codes = {}
for k, v in pairs wraps
  wrap_codes[v] = k

filter_codes = {}
for k, v in pairs filters
  filter_codes[v] = k

{
  :keys
  :key_codes

  :buttons
  :button_codes

  :formats
  :format_codes

  :wraps
  :wrap_codes

  :filters
  :filter_codes

  :blend_modes
  :shapes
  :aligns
}
