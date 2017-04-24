(*
 * Copyright 2017 Cedric LE MOIGNE, cedlemo@gmx.com
 * This file is part of OCaml-GObject-Introspection.
 *
 * OCaml-GObject-Introspection is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OCaml-GObject-Introspection is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCaml-GObject-Introspection.  If not, see <http://www.gnu.org/licenses/>.
 *)

(** GIFunctionInfo — Module with type representing a function *)

(** functioninfo represents a function, method or constructor. To find out what
 kind of entity a functioninfo represents, call GIFunctionInfo.get_flags.
 See also GICallableInfo for information on how to retreive arguments and other
 metadata. *)
type functioninfo

type flags =
  | Is_method      (** is a method. *)
  | Is_constructor (** is a constructor. *)
  | Is_getter      (** is a getter of a GIPropertyInfo. *)
  | Is_setter      (** is a setter of a GIPropertyInfo. *)
  | Wraps_vfunc    (** represents a virtual function. *)
  | Throws         (** the function may throw an error. *)

(** Obtain the GIFunctionInfo.flags for the info . *)
external get_flags:
  functioninfo -> flags list = "caml_g_function_info_get_flags_c"

(** Check if the info has the flag Is_method *)
external is_method:
  functioninfo -> bool = "caml_g_function_info_is_method_c"
(* TODO test_is_method *)

(** Check if the info has the Is_constructor flag *)
external is_constructor:
  functioninfo -> bool = "caml_g_function_info_is_constructor_c"
(* TODO test is_constructor *)

(** Check if the info has the Is_getter flag *)
external is_getter:
  functioninfo -> bool = "caml_g_function_info_is_getter_c"
(* TODO test is_getter *)

(** Check if the info has the Is_getter flag *)
external is_setter:
  functioninfo -> bool = "caml_g_function_info_is_setter_c"
(* TODO test is_setter *)

(** Check if the info has the Wraps_vfunc flag *)
external wraps_vfunc:
  functioninfo -> bool = "caml_g_function_info_wraps_vfunc_c"
(* TODO test is_setter *)

(** Check if the info has the Throws flag *)
external throws:
  functioninfo -> bool = "caml_g_function_info_throws_c"

(** Obtain the symbol of the function. The symbol is the name of the exported
    function, suitable to be used as an argument to g_module_symbol(). *)
external get_symbol:
  functioninfo -> string = "caml_g_function_info_get_symbol_c"

(* TODO : GIPropertyInfo *	g_function_info_get_property ()
 * TODO : GIVFuncInfo *	g_function_info_get_vfunc ()
 * TODO : gboolean	g_function_info_invoke ()
 * TODO : GQuark	g_invoke_error_quark ()
 *)