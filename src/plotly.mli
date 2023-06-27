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
end

module Layout : sig
  type t = private Attribute.t list

  val title : string -> t
  val barmode : string -> t

  (* Build custom layout attributes *)
  val layout : Attribute.t list -> t
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
end

module Figure : sig
  type t =
    { graphs : Graph.t list;
      layout : Layout.t }

  val figure : Graph.t list -> Layout.t list -> t
end
