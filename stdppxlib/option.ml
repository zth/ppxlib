type 'a t = 'a option

let map ~f = function None -> None | Some x -> Some (f x)

let fold ~f ~init = function None -> init | Some x -> f init x
