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

(** BuilderUtils module : Regroups a set of functions needed in almost all the
    Builder* modules. *)

(** Raise an Not_implemented exception with the message given in argument. *)
val raise_not_implemented:
  string -> unit

(** Raise a Not_implemented exception with a string representation of the
    GITypes.tag, given in argument, that will be appended to the message given
    in the first argument. *)
val raise_tag_not_implemented:
  string -> GITypes.tag -> unit

(** Log a Not implemented message with a string representation of the
    GITypes.tag, given in argument, that will be appended to the message given
    in the first argument. *)
val log_tag_not_implemented:
  string -> GITypes.tag -> unit

(** Transforms a GITypes.tag to the corresponding types for the mli file and
    the ml file. For example, the GITypes.Int8 tag returns ("int", "int8_t").
    The "int" string is used in the OCaml header file for signature while the
    int8_t is used in OCaml file for Ctypes types usage.*)
val type_tag_to_ctypes_strings:
  GITypes.tag -> (string * string)

(** Get the Ctypes typ representation of a GITypes.tag. For example, if the tag
    is GITypes.Int8, it will returns "int8_t". *)
val type_tag_to_ctypes_typ_string:
  GITypes.tag -> string

(** Get the OCaml type representation for a GITypes.tag. For example, if the tag
    is GITypes.Int8, it will returns "int". *)
val type_tag_to_ocaml_type_string:
  GITypes.tag -> string

(** Add an open directives in a file for a module name.*)

val write_open_module:
  Pervasives.out_channel -> string -> unit

(** Add the line "open Ctypes\n" in a file. *)
val add_open_ctypes:
  Pervasives.out_channel -> unit

(** Add the line "open Foreign\n" in a file. *)
val add_open_foreign:
  Pervasives.out_channel -> unit

(** Add empty line in a file. *)
val add_empty_line:
  Pervasives.out_channel -> unit

(** Uses this to check if a autogenerated variable name does not match an
    OCaml keyword (ie: end ...). *)
val escape_OCaml_keywords:
  string -> string

(** Check if an autogenerated variable name start or not with a number. *)
val has_number_at_beginning:
  string -> bool

(** Check if an autogenerated variable name does not start with a number. If so
    it prepends a "_". *)
val escape_number_at_beginning:
  string -> string

(** Check if the string given in argument is not an OCaml keyword or does not
    start with a number. *)
val ensure_valid_variable_name:
  string -> string
