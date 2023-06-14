open Js_of_ocaml

module Html = Dom_html

open Plotly_demo
open Plotly_jsoo
open Jsoo
open Jstools

let draw main fig =
  let div = Html.createDiv Html.document in
  Dom.appendChild main div;
  create div fig

let start _ =
  let main = Option.get @@ getById_coerce Html.CoerceTo.div "main" in
  List.iter (draw main) Demo.figures;
  Js._false

let () = Html.window##.onload := Html.handler start
