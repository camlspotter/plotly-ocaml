include Base

module Data = struct
  open Attributes

  type t = Attribute.t list

  let mode   = string "mode"
  let name   = string "name"
  let labels = array "labels" Type.String
  let values = array "values" Type.Float
  let text   = array "text" Type.String
  let orientation = string "orientation"
  let x = array "x" Type.Float
  let y = array "y" Type.Float
  let z = array "z" Type.Float

  let xy xys =
    let xs = Array.map fst xys in
    let ys = Array.map snd xys in
    x xs @ y ys

  let xyz xyzs =
    let xs = Array.map (fun (x,_,_) -> x) xyzs in
    let ys = Array.map (fun (_,y,_) -> y) xyzs in
    let zs = Array.map (fun (_,_,z) -> z) xyzs in
    x xs @ y ys @ z zs

  let data ds = ds
end

module Layout = struct
  open Attributes

  type t = Attribute.t list

  let title = string "title"
  let barmode = string "barmode"

  let layout ats = ats
end

module Graph = struct
  type t = { type_ : string; data : Data.t }

  let scatter data_list = { type_ = "scatter"; data= List.flatten data_list }
  let scatter3d data_list = { type_ = "scatter3d"; data= List.flatten data_list }
  let bar data_list = { type_ = "bar"; data= List.flatten data_list }
  let pie data_list = { type_ = "pie"; data= List.flatten data_list }
  let histogram data_list = { type_ = "histogram"; data= List.flatten data_list }

  let graph type_ data_list = { type_; data= List.flatten data_list }
end

module Figure = struct
  type t =
    { graphs : Graph.t list;
      layout : Layout.t }

  let figure graphs layout = { graphs; layout= List.flatten layout }
end
