open Plotly
open Plotly_demo
open Plotly_python.Python

let get_title figure : string option =
  match List.assoc_opt "title" (figure.Figure.layout :> Attribute.t list) with
  | Some (Value (String, s)) -> Some s
  | _ -> None

let cntr = ref 0

let filename figure =
  match get_title figure with
  | Some x -> x ^ ".png"
  | None ->
      incr cntr;
      Printf.sprintf "Unknown-%d.png" !cntr

let () =
  List.iter (fun figure ->
      let f = of_figure figure in
      show f;
      write_image f (filename figure);
    ) Demo.figures
