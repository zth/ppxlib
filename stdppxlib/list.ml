include ListLabels

type 'a t = 'a list

let is_empty = function [] -> true | _ -> false

let slow_map ~f l = rev (rev_map l ~f)

let rec count_map ~f l ctr =
  match l with
  | [] -> []
  | [x1] ->
    let f1 = f x1 in
    [f1]
  | [x1; x2] ->
    let f1 = f x1 in
    let f2 = f x2 in
    [f1; f2]
  | [x1; x2; x3] ->
    let f1 = f x1 in
    let f2 = f x2 in
    let f3 = f x3 in
    [f1; f2; f3]
  | [x1; x2; x3; x4] ->
    let f1 = f x1 in
    let f2 = f x2 in
    let f3 = f x3 in
    let f4 = f x4 in
    [f1; f2; f3; f4]
  | x1 :: x2 :: x3 :: x4 :: x5 :: tl ->
    let f1 = f x1 in
    let f2 = f x2 in
    let f3 = f x3 in
    let f4 = f x4 in
    let f5 = f x5 in
    f1 :: f2 :: f3 :: f4 :: f5 ::
    (if ctr > 1000
     then slow_map ~f tl
     else count_map ~f tl (ctr + 1))

let map ~f l = count_map ~f l 0

let mem ~equal l elm = exists ~f:(fun x -> equal elm x) l
