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

  let rec of_json v =
    let open Option in
    match v with
    | `Float f -> Some (Value (float f))
    | `String s -> Some (Value (string s))
    | `A vs ->
        let* vs = mapM of_json vs in
        (match vs with
        | [] -> None
        | v::vs ->
            let Value (ty, _) = v in
            let rec check acc = function
              | [] -> Some (Value (Type.Array ty, Array.of_list @@ List.rev acc))
              | v'::vs ->
                  let Value (ty', v') = v' in
                  match Type.eq ty ty' with
                  | Some Eq -> check (v'::acc) vs
                  | None -> None
            in
            check [] (v::vs))
    | _ -> None
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

  let of_json j =
    let open Option in
    match j with
    | `O kvs ->
        Option.mapM (fun (k, v) ->
            let+ res = Value.of_json v in
            (k, res)) kvs
    | _ -> None
end
