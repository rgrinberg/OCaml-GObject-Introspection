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

(** GIFunctionInfo — Struct representing a function. *)

open Ctypes
open Foreign
open Conversions

type t
let functioninfo : t structure typ = structure "GIFunctionInfo"

(** Obtain the symbol of the function. The symbol is the name of the exported
    function, suitable to be used as an argument to g_module_symbol().*)
let get_symbol =
  foreign "g_function_info_get_symbol"
    (ptr functioninfo @-> returning string)

type flags =
  | Is_method
  | Is_constructor
  | Is_getter
  | Is_setter
  | Wraps_vfunc
  | Throws

let get_flags info =
  let get_flags_raw =
    foreign "g_function_info_get_flags"
      (ptr functioninfo @-> returning int)
  in let flags = [] in
  let c_flags = get_flags_raw info in
  if ((c_flags land (1 lsl 0)) != 0) then ignore (Is_method :: flags);
  if ((c_flags land (1 lsl 1)) != 0) then ignore (Is_constructor :: flags);
  if ((c_flags land (1 lsl 2)) != 0) then ignore (Is_getter :: flags);
  if ((c_flags land (1 lsl 3)) != 0) then ignore (Is_setter :: flags);
  if ((c_flags land (1 lsl 4)) != 0) then ignore (Wraps_vfunc :: flags);
  if ((c_flags land (1 lsl 5)) != 0) then ignore (Throws :: flags);
  flags
