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
let baseinfo : t structure typ = structure "GIBaseInfo"

let base_info_ref =
  foreign "g_base_info_ref" (ptr baseinfo @-> returning (ptr baseinfo))

let base_info_unref =
  foreign "g_base_info_unref" (ptr baseinfo @-> returning void)

let get_name =
  foreign "g_base_info_get_name" (ptr baseinfo @-> returning string_opt)

let equal =
  foreign "g_base_info_equal" (ptr baseinfo @-> ptr baseinfo @-> returning bool)

let get_namespace =
  foreign "g_base_info_get_namespace" (ptr baseinfo @-> returning string)

let is_deprecated =
  foreign "g_base_info_is_deprecated" (ptr baseinfo @-> returning bool)

type baseinfo_type =
  | Invalid
  | Function
  | Callback
  | Struct
  | Boxed
  | Enum
  | Flags
  | Object
  | Interface
  | Constant
  | Invalid_0
  | Union
  | Value
  | Signal
  | Vfunc
  | Property
  | Field
  | Arg
  | Type
  | Unresolved

let baseinfo_type_of_int = function
  | 0 -> Invalid
  | 1 -> Function
  | 2 -> Callback
  | 3 -> Struct
  | 4 -> Boxed
  | 5 -> Enum
  | 6 -> Flags
  | 7 -> Object
  | 8 -> Interface
  | 9 -> Constant
  | 10 -> Invalid_0
  | 11 -> Union
  | 12 -> Value
  | 13 -> Signal
  | 14 -> Vfunc
  | 15 -> Property
  | 16 -> Field
  | 17 -> Arg
  | 18 -> Type
  | 19 -> Unresolved
  | value  -> let message = String.concat " " ["GIBaseInfo baseinfo_type value";
                                               string_of_int value;
                                               "should not have been reached"]
    in raise (Failure message)

let string_of_baseinfo_type baseinfo_t =
  match baseinfo_t with
  | Invalid -> "invalid"
  | Function -> "function"
  | Callback -> "callback"
  | Struct -> "struct"
  | Boxed -> "boxed"
  | Enum -> "enum"
  | Flags -> "flags"
  | Object -> "object"
  | Interface -> "interface"
  | Constant -> "constant"
  | Invalid_0 -> "deleted"
  | Union -> "union"
  | Value -> "enum"
  | Signal -> "signal"
  | Vfunc -> "virtual"
  | Property -> "GObject"
  | Field -> "struct"
  | Arg -> "argument"
  | Type -> "type"
  | Unresolved -> "unresolved"

let get_type info =
  let get_type_raw =
    foreign "g_base_info_get_type"
      (ptr baseinfo @-> returning int)
  in let value = get_type_raw info in
  baseinfo_type_of_int value

let add_unref_finaliser info =
  let _ = Gc.finalise (fun i ->
      base_info_unref i
    ) info in
  info

(** GIRealInfo private struct only used to check ref_count and memory leaks *)
(* type realinfo
let realinfo : realinfo structure typ = structure "GIRealInfo"
let girealinfo_type = field realinfo "type" (int32_t)
let girealinfo_ref_count = field realinfo "ref_count" (int)
let () = seal realinfo

let realinfo_of_baseinfo info =
  coerce (ptr baseinfo) (ptr realinfo) info

let get_ref_count info =
  let realinfo = realinfo_of_baseinfo info in
  getf (!@realinfo) girealinfo_ref_count

let ref_count_file = (Sys.getcwd ()) ^ "/ref_count.log"
   *)
(* http://stackoverflow.com/questions/8090490/how-to-implement-appendfile-function *)
(*
let write_ref_count_log message =
  let oc = open_out_gen [Open_wronly; Open_append; Open_creat; Open_text] 0o640 ref_count_file in
  let _ = output_string oc message in
  close_out oc

let base_info_ref info =
  let base_info_ref_raw =
    foreign "g_base_info_ref" (ptr baseinfo @-> returning (ptr baseinfo))
  in
  let ref_count = get_ref_count info in
  let addr = raw_address_of_ptr (coerce (ptr baseinfo) (ptr void) info) in
  let name = match get_name info with
    | None -> "No name"
    | Some str -> str
  in
  let message = String.concat " " ["++ Ref count";
                                   Nativeint.to_string addr;
                                   string_of_int ref_count;
                                   "ref to  ";
                                   string_of_int (ref_count + 1);
                                   name;
                                   "\n"] in
  let _ = write_ref_count_log message in
  base_info_ref_raw info
*)

(*
let base_info_unref info =
  let base_info_unref_raw =
    foreign "g_base_info_unref" (ptr baseinfo @-> returning void)
  in
  let ref_count = get_ref_count info in
  let addr = raw_address_of_ptr (coerce (ptr baseinfo) (ptr void) info) in
  let name = match get_name info with
    | None -> "No name"
    | Some str -> str
  in
  let message = String.concat " " ["-- Ref count";
                                   Nativeint.to_string addr;
                                   string_of_int ref_count;
                                   "unref to";
                                   string_of_int (ref_count - 1);
                                   name;
                                   "\n"] in
  let _ = write_ref_count_log message in
  base_info_unref_raw info
*)
