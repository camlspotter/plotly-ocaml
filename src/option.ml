include Stdlib.Option
let (let*) = bind
let (let+) x f = map f x
let rec mapM' acc f = function
  | [] -> Some (List.rev acc)
  | x::xs ->
      let* x = f x in
      mapM' (x::acc) f xs
let mapM f = mapM' [] f
