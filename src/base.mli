module Type : sig
  type 'a t =
    | Float : float t
    | String : string t
    | Array : 'a t -> 'a array t
    | List : 'a t -> 'a list t
    | Tup2 : 'a t * 'b t -> ('a * 'b) t
    | Tup3 : 'a t * 'b t * 'c t -> ('a * 'b * 'c) t

  type type_ = Type : _ t -> type_
end

module Value : sig
  type 'a t = 'a Type.t * 'a
  type value = Value : 'a t -> value

  val float : float -> float t
  val string : string -> string t
  val array : 'a Type.t -> 'a array -> 'a array t
  val list : 'a Type.t -> 'a list -> 'a list t
  val tup2 : 'a t -> 'b t -> ('a * 'b) t
  val tup3 : 'a t -> 'b t -> 'c t -> ('a * 'b * 'c) t

  val to_json : value -> Ezjsonm.value
  val of_json : 'a Type.t -> Ezjsonm.value -> value option
end

module Attribute : sig
  type t = string * Value.value
end

module Attributes : sig
  type t = Attribute.t list

  val float : string -> float -> t
  val string : string -> string -> t
  val array : string -> 'a Type.t -> 'a array -> t
  val list : string -> 'a Type.t -> 'a list -> t
  val tup2 : string -> 'a Value.t -> 'b Value.t -> t
  val tup3 : string -> 'a Value.t -> 'b Value.t -> 'c Value.t -> t

  val to_json : t -> Ezjsonm.value
  val of_json : (string * Type.type_) list -> Ezjsonm.value -> t option
end
