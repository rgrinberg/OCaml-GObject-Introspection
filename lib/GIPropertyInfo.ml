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

open Ctypes
open Foreign

type t
let propertyinfo : t structure typ = structure "GIPropertyInfo"

let get_ownership_transfer info =
  let get_ownership_transfer_raw =
    foreign "g_property_info_get_ownership_transfer"
      (ptr propertyinfo @-> returning int) in
  let transfer = get_ownership_transfer_raw info in
  GIArgInfo.transfer_of_int transfer

let get_type info =
  let get_type_raw =
    foreign "g_property_info_get_type"
      (ptr propertyinfo @-> returning (ptr GITypeInfo.typeinfo)) in
  let info' = get_type_raw info in
  GITypeInfo.add_unref_finaliser info'

let get_flags info =
  let get_flags_raw =
    foreign "g_property_info_get_flags"
      (ptr propertyinfo @-> returning int32_t) in
  let flag = get_flags_raw info in
  GIArgInfo.param_flags_of_int32 flag

(* TODO : check that the info can be casted to property info ? *)
let cast_from_baseinfo info =
  coerce (ptr GIBaseInfo.baseinfo) (ptr propertyinfo) info

let cast_to_baseinfo info =
  coerce (ptr propertyinfo) (ptr GIBaseInfo.baseinfo) info

let add_unref_finaliser info =
  let _ = Gc.finalise (fun i ->
      let i' = cast_to_baseinfo i in
      GIBaseInfo.base_info_unref i') info
  in info

let from_baseinfo info =
  let _ = GIBaseInfo.base_info_ref info in
  let info' = cast_from_baseinfo info in
  add_unref_finaliser info'

let to_baseinfo info =
  let info' = cast_to_baseinfo info in
  let _ = GIBaseInfo.base_info_ref info' in
  let _ = Gc.finalise (fun i ->
      GIBaseInfo.base_info_unref i) info' in
  info'
