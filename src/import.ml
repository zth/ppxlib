include Stdio
include Ppxlib_ast
include Stdppxlib

(* This is not re-exported by Base and we can't use [%here] in ppxlib *)
external __FILE__ : string = "%loc_FILE"

include Ast
