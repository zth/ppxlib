include StringLabels

(* To avoid issues with s.[i] syntax *)
module String = Ppxlib_caml.String

let capitalize = Ppxlib_caml.String.capitalize_ascii
let uncapitalize = Ppxlib_caml.String.uncapitalize_ascii
let uppercase = Ppxlib_caml.String.uppercase_ascii
let lowercase = Ppxlib_caml.String.lowercase_ascii

let differ s s' = not (equal s s')

let is_empty s = length s = 0

let rec check_prefix s ~prefix len i =
  i = len || s.[i] = prefix.[i] && check_prefix s ~prefix len (i + 1)

let is_prefix ~prefix s =
  let len = length s in
  let prefix_len = length prefix in
  len >= prefix_len && check_prefix s ~prefix prefix_len 0

let drop_prefix s prefix_len =
  let len = length s in
  if prefix_len < 0 then
    let msg = Printf.sprintf "%s.drop_prefix: invalid prefix length: %d" __MODULE__ prefix_len in
    invalid_arg msg
  else if prefix_len >= len then
    ""
  else
    sub s ~pos:prefix_len ~len:(len - prefix_len)
