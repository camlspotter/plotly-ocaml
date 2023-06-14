open Js_of_ocaml

val from_Some : 'a option -> 'a

val from_Ok : ('a, 'b) result -> 'a

val from_js_Some : 'a Js.opt -> 'a

val ( !$ ) : string -> Js.js_string Js.t
val ( ?$ ) : Js.js_string Js.t -> string

module Console : sig
  val log : 'a -> unit
  val logf : ('a, Format.formatter, unit, unit) format4 -> 'a
end

val alert : string -> unit

val alertf : ('a, Format.formatter, unit, unit) format4 -> 'a

val show_as_json : 'a -> string

val pp_as_json : Format.formatter -> 'a -> unit

exception No_element_id of string

val getById : string -> Dom_html.element Js.t option

val getById_exn : string -> Dom_html.element Js.t

val getById_coerce : (Dom_html.element Js.t -> 'a Js.opt) -> string -> 'a option

val getById_coerce_exn : (Dom_html.element Js.t -> 'a Js.opt) -> string -> 'a

val elem : #Dom_html.element Js.t -> Dom_html.element Js.t

val is_worker : unit -> bool

val now : unit -> Js.date Js.t
