module Type : sig
  type 'a t =
    | Float : float t
    | String : string t
    | Array : 'a t -> 'a array t
end

module Value : sig
  type 'a t = 'a Type.t * 'a
  type value = Value : 'a t -> value
  val float : float -> float t
  val string : string -> string t
  val array : 'a Type.t -> 'a array -> 'a array t
end

module Attribute : sig
  type t = string * Value.value
end

module Attributes : sig
  val float : string -> float -> Attribute.t list
  val string : string -> string -> Attribute.t list
  val array : string -> 'a Type.t -> 'a array -> Attribute.t list
end
