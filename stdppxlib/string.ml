include StringLabels

(* To avoid issues with s.[i] syntax *)
module String = Ppxlib_caml.String

let differ s s' = not (equal s s')

let to_sexp = Sexplib.Std.sexp_of_string

let is_empty s = length s = 0

let capitalize = Ppxlib_caml.String.capitalize_ascii
let uncapitalize = Ppxlib_caml.String.uncapitalize_ascii
let uppercase = Ppxlib_caml.String.uppercase_ascii
let lowercase = Ppxlib_caml.String.lowercase_ascii

let rec check_prefix s ~prefix len i =
  i = len || s.[i] = prefix.[i] && check_prefix s ~prefix len (i + 1)

let is_prefix ~prefix s =
  let len = length s in
  let prefix_len = length prefix in
  len >= prefix_len && check_prefix s ~prefix prefix_len 0

let invalid_prefix_len ~caller prefix_len =
  let msg = Printf.sprintf "%s.%s: invalid prefix length: %d" __MODULE__ caller prefix_len in
  invalid_arg msg

let drop_prefix s prefix_len =
  let len = length s in
  if prefix_len < 0 then
    invalid_prefix_len ~caller:"drop_prefix" prefix_len
  else if prefix_len >= len then
    ""
  else
    sub s ~pos:prefix_len ~len:(len - prefix_len)

let prefix s prefix_len =
  let len = length s in
  if prefix_len < 0 then
    invalid_prefix_len ~caller:"prefix" prefix_len
  else if prefix_len >= len then
    s
  else
    sub s ~pos:0 ~len:prefix_len

let split ~on s = Ppxlib_caml.String.split_on_char on s
