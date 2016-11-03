-- type checking for classes
_type = type
export type = (v) ->
  base = _type v
  if base == "table"
    cls = v.__class
    return cls.__name if cls
  base
