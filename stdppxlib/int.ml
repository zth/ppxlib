type t = int

let max_value = max_int

let compare i i' =
  if i < i' then -1 else if i = i' then 0 else 1
