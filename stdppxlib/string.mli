type t = string
 
include module type of struct include StringLabels end with type t := t

val differ : t -> t -> bool

val to_sexp : t -> Sexplib0.Sexp.t

val is_empty : t -> bool

val capitalize : t -> t
val uncapitalize : t -> t
val uppercase : t -> t
val lowercase : t -> t

val is_prefix : prefix: t -> t -> bool

val drop_prefix : t -> int -> t

val prefix : t -> int -> t

val split : on: char -> t -> t list
