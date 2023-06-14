open Js_of_ocaml

module Html = Dom_html

let from_Some = Option.get
let from_Ok = Result.get_ok

let from_js_Some x = from_Some @@ Js.Opt.to_option x

let (!$) = Js.string
let (?$) = Js.to_string

module Console = struct
  let log a = Js_of_ocaml.Firebug.console##log a
  let logf fmt = Format.kasprintf (fun s -> log !$s) fmt
end

(* eprintf to console *)
let () =
  let buf = Buffer.create 1024 in
  Format.pp_set_formatter_output_functions
    Format.err_formatter
    (Buffer.add_substring buf)
    (fun () ->
       Console.log !$(Buffer.contents buf);
       Buffer.clear buf)

let alert s =
  Format.eprintf "%s@." s;
  Html.window##alert !$s

let alertf fmt = Format.kasprintf (fun s -> alert s) fmt

let show_as_json x = ?$(Js_of_ocaml.Json.output x)
let pp_as_json ppf x = Format.pp_print_string ppf ?$(Js_of_ocaml.Json.output x)

exception No_element_id of string

let getById_exn n =
  match Html.getElementById n with
  | exception Not_found -> raise (No_element_id n)
  | x -> x

let getById n =
  match Html.getElementById n with
  | exception Not_found -> None
  | x -> Some x

let getById_coerce_exn coerce s =
  match Html.getElementById_coerce s coerce with
  | Some x -> x
  | None -> raise (No_element_id s)

let getById_coerce coerce s =
  Html.getElementById_coerce s coerce

let elem x = (x :> Html.element Js.t)

let is_worker () =
  try ignore (Js.Unsafe.eval_string "window"); false with _ -> true

let now () = new%js Js.date_now
