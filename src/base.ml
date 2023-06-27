type (_, _) eq = Eq : ('a, 'a) eq

module Type = struct
  type 'a t =
    | Float : float t
    | String : string t
    | Array : 'a t -> 'a array t

  type type_ = Type : 'a t -> type_

  let rec eq : type a b . a t -> b t -> (a, b) eq option = fun a b ->
    match a, b with
    | Float, Float -> Some Eq
    | String, String -> Some Eq
    | Array a, Array b ->
        (match eq a b with
         | Some Eq -> Some Eq
         | _ -> None)
    | _ -> None

  let _eq = eq
end

module Value = struct
  type 'a t = 'a Type.t * 'a
  type value = Value : 'a t -> value
  let float f : float t = Type.Float, f
  let string s : string t = Type.String, s
  let array ty vs : 'a array t = Type.Array ty, vs

  let rec to_json v : Ezjsonm.value =
    match v with
    | Value (Type.Float, f) -> `Float f
    | Value (String, s) -> `String s
    | Value (Array ty, xs) -> `A (List.map (fun x -> to_json (Value (ty, x))) @@ Array.to_list xs)

  let rec of_json : type a . a Type.t -> Ezjsonm.value -> a option =
    fun ty v ->
    let open Option in
    match ty, (v : Ezjsonm.value) with
    | Type.Float, `Float f -> Some f
    | String, `String s -> Some s
    | Array ty, `A vs ->
        let+ res = mapM (of_json ty) vs in
        Array.of_list res
    | _ -> None

  let of_json ty v =
    let open Option in
    let+ v = of_json ty v in
    Value (ty, v)
end

module Attribute = struct
  type t = string * Value.value
end

module Attributes = struct
  type t = Attribute.t list

  open Value
  let float n f = [n, Value (Value.float f)]
  let string n s = [n, Value (Value.string s)]
  let array n ty vs = [n, Value (Value.array ty vs)]

  let to_json xs =
    `O (List.map (fun (k, v) -> k, Value.to_json v) xs)

  let of_json ktys j =
    let open Option in
    match j with
    | `O kvs ->
        Option.mapM (fun (k, v) ->
            match List.assoc_opt k ktys with
            | None -> None
            | Some (Type.Type ty) ->
                let+ res = Value.of_json ty v in
                (k, res)) kvs
    | _ -> None
end
