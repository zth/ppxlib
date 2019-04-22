type 'a t = 'a option

val map : f: ('a -> 'b) -> 'a t -> 'b t

val fold : f: ('acc -> 'a -> 'acc) -> init: 'acc -> 'a t -> 'acc
