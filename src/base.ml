module Type = struct
  type 'a t =
    | Float : float t
    | String : string t
    | Array : 'a t -> 'a array t
end

module Value = struct
  type 'a t = 'a Type.t * 'a
  type value = Value : 'a t -> value
  let float f : float t = Type.Float, f
  let string s : string t = Type.String, s
  let array ty vs : 'a array t = Type.Array ty, vs
end

module Attribute = struct
  type t = string * Value.value
end

module Attributes = struct
  open Value
  let float n f = [n, Value (Value.float f)]
  let string n s = [n, Value (Value.string s)]
  let array n ty vs = [n, Value (Value.array ty vs)]
end
