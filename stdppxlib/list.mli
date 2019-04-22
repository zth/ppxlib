include module type of struct include ListLabels end

type 'a t = 'a list

val is_empty : 'a t -> bool

val mem : equal: ('a -> 'a -> bool) -> 'a t -> 'a -> bool
