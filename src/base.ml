module Type = struct
  type 'a t =
    | Float : float t
    | String : string t
    | Array : 'a t -> 'a array t
    | List : 'a t -> 'a list t
    | Tup2 : 'a t * 'b t -> ('a * 'b) t
    | Tup3 : 'a t * 'b t * 'c t -> ('a * 'b * 'c) t
end

module Value = struct
  type 'a t = 'a Type.t * 'a
  type value = Value : 'a t -> value
  let float f : float t = Type.Float, f
  let string s : string t = Type.String, s
  let array ty vs : 'a array t = Type.Array ty, vs
  let list ty vs : 'a list t = Type.List ty, vs
  let tup2 (tx, x) (ty, y) : ('a * 'b) t = Type.Tup2 (tx, ty), (x,y)
  let tup3 (tx, x) (ty, y) (tz, z) : ('a * 'b * 'c) t = Type.Tup3 (tx, ty, tz), (x,y,z)
end

module Attribute = struct
  type t = string * Value.value
end

module Attributes = struct
  open Value
  let float n f = [n, Value (Value.float f)]
  let string n s = [n, Value (Value.string s)]
  let array n ty vs = [n, Value (Value.array ty vs)]
  let list n ty vs = [n, Value (Value.list ty vs)]
  let tup2 n x y = [n, Value (Value.tup2 x y)]
  let tup3 n x y z = [n, Value (Value.tup3 x y z)]
end
