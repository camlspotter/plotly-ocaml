open Js_of_ocaml

type data
type layout
type config

(* Plotly.newPlot(graphDiv, data, layout, config) *)
type plotly =
  < newPlot :
      Dom_html.divElement Js.t ->
      data Js.t Js.js_array Js.t ->
      layout Js.t ->
      config Js.t -> unit Js.meth;

    react :
      Dom_html.divElement Js.t ->
      data Js.t Js.js_array Js.t ->
      layout Js.t ->
      config Js.t -> unit Js.meth;
  >

val plotly : plotly Js.t

val create : Dom_html.divElement Js.t -> Plotly.Figure.t -> unit
