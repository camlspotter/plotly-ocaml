(* https://plotly.com/javascript/plotlyjs-function-reference/ *)

open Plotly
open Js_of_ocaml
module Html = Dom_html

let rec conv_value v =
  let open Value in
  match v with
  | Value (Float, f) -> Js.Unsafe.inject f
  | Value (String, s) -> Js.Unsafe.inject @@ Js.string s
  | Value (Array ty, vs) ->
      let vs = Array.map (fun v -> conv_value (Value (ty, v))) vs in
      Js.Unsafe.inject @@ Js.array vs

let obj_of_attributes (xs : Attribute.t list) : _ Js.t =
  Js.Unsafe.obj @@
  Array.of_list @@
  List.fold_left (fun acc (n, v) ->
      if List.mem_assoc n acc then assert false; (* warning? *)
      (n, conv_value v) :: acc) [] xs

let obj_of_graph_object Graph.{type_; data} =
  obj_of_attributes
  @@ Attributes.string "type" type_
     @ (data :> Attribute.t list)

let obj_of_layout (layout : Plotly.Layout.t) =
  obj_of_attributes (layout :> Attribute.t list)

type data
type layout
type config

(* Plotly.newPlot(graphDiv, data, layout, config) *)
type plotly =
  < newPlot :
      Html.divElement Js.t ->
      data Js.t Js.js_array Js.t ->
      layout Js.t ->
      config Js.t -> unit Js.meth;

    react :
      Html.divElement Js.t ->
      data Js.t Js.js_array Js.t ->
      layout Js.t ->
      config Js.t -> unit Js.meth;
  >

let plotly : plotly Js.t = Js.Unsafe.pure_js_expr "Plotly"

let create div fig =
  plotly##newPlot
    div
    (Js.array
     @@ Array.of_list
     @@ List.map obj_of_graph_object fig.Figure.graphs)
    (obj_of_layout fig.layout)
    (Js.Unsafe.obj [||])
