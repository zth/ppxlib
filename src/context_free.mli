(** Context free rewriting *)

open! Import

(** Local rewriting rules.

    This module lets you define local rewriting rules, such as extension point
    expanders. It is not completely generic and you cannot define any kind of rewriting,
    it currently focuses on what is commonly used. New scheme can be added on demand.

    We have some ideas to make this fully generic, but this hasn't been a priority so
    far.
*)
module Rule : sig
  type t

  (** Rewrite an extension point *)
  val extension : Extension.t -> t

  (** [special_function id expand] is a rule to rewrite a function call at parsing time.
      [id] is the identifier to match on and [expand] is used to expand the full function
      application (it gets the Pexp_apply node). If the function is found in the tree
      without being applied, [expand] gets only the identifier (Pexp_ident node) so you
      should handle both cases.

      [expand] must decide whether the expression it receive can be rewritten or not.
      Especially ppxlib makes the assumption that [expand] is idempotent. It will loop
      if it is not. *)
  val special_function
    :  string
    -> (expression -> expression option)
    -> t

  (** Used for the [constant] function. *)
  module Constant_kind : sig
    type t = Float | Integer
  end

  (** [constant kind suffix expander] Registers an extension for transforming constants
      literals, based on the suffix character. *)
  val constant
    :  Constant_kind.t
    -> char
    -> (Location.t -> string -> Parsetree.expression)
    -> t
end

(**/**)
(*_ This API is not stable *)
module Generated_code_hook : sig
  type 'a single_or_many =
    | Single of 'a
    | Many   of 'a list

  (*_ Hook called whenever we generate code some *)
  type t =
    { f : 'a. 'a Extension.Context.t -> Location.t -> 'a single_or_many -> unit }

  val nop : t
end

module Expect_mismatch_handler : sig
  type t =
    { f : 'a. 'a Attribute.Floating.Context.t -> Location.t -> 'a list -> unit }

  val nop : t
end
(**/**)

(* TODO: a simple comment here is fine, while we would expect only docstring or (*_ *)
   comments to be accepted. On the contrary, docstrings are *not* accepted.

   This means https://github.com/ocaml/ocaml/pull/477 was not complete and indeed the
   parser should be fixed. *)
class map_top_down
  :  ?expect_mismatch_handler:Expect_mismatch_handler.t
    (* default: Expect_mismatch_handler.nop *)
    -> ?generated_code_hook:Generated_code_hook.t
    (* default: Generated_code_hook.nop *)
    -> Rule.t list
    -> Ast_traverse.map_with_path
