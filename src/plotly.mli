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

module Data : sig
  type t = private Attribute.t list

  val mode : string -> t
  val name : string -> t
  val labels : string array -> t
  val values : float array -> t
  val text : string array -> t
  val orientation : string -> t
  val x : float array -> t
  val y : float array -> t
  val z : float array -> t

  (* The argument is splitted to build attributes [x] and [y] *)
  val xy : (float * float) array -> t

  (* The argument is splitted to build attributes [x], [y], and [z] *)
  val xyz : (float * float * float) array -> t

  (* Build custom data attributes *)
  val data : Attribute.t list -> t

  val to_json : t -> Ezjsonm.value
  val of_json : (string * Type.type_) list -> Ezjsonm.value -> t option
end

module Layout : sig
  type t = private Attribute.t list

  val title : string -> t
  val barmode : string -> t

  (* Build custom layout attributes *)
  val layout : Attribute.t list -> t

  val to_json : t -> Ezjsonm.value
  val of_json : (string * Type.type_) list -> Ezjsonm.value -> t option
end

module Graph : sig
  type t = { type_: string; data : Data.t }

  val scatter : Data.t list -> t
  val scatter3d : Data.t list -> t
  val bar : Data.t list -> t
  val pie : Data.t list -> t
  val histogram : Data.t list -> t

  (* Build custom graph *)
  val graph : string -> Data.t list -> t

  val to_json : t -> Ezjsonm.value
  val of_json : (string * Type.type_) list -> Ezjsonm.value -> t option
end

module Figure : sig
  type t =
    { graphs : Graph.t list;
      layout : Layout.t }

  val figure : Graph.t list -> Layout.t list -> t

  val to_json : t -> Ezjsonm.value

  val of_json :
    data_types:(string * Type.type_) list ->
    layout_types:(string * Type.type_) list ->
    Ezjsonm.value -> t option
end
