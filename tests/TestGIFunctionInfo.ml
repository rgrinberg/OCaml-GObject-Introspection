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

open TestUtils
open OUnit2
open GObjectIntrospection

let namespace = "GObject"
let repo = GIRepository.get_default ()
let typelib = GIRepository.require repo namespace ()
let name = "signal_name"

let get_function_info () =
  match GIRepository.find_by_name repo namespace name with
  | None -> None
  | Some (base_info) -> match GIBaseInfo.get_type base_info with
    | GIBaseInfo.Function -> let info = GIFunctionInfo.from_baseinfo base_info in
      Some info
    | _ -> None

let test_function_info fn =
  match get_function_info () with
  | None -> assert_equal_string name "No base info found"
  | Some info -> fn info

let test_get_symbol test_ctxt =
  test_function_info (fun info ->
      assert_equal "g_signal_name" (GIFunctionInfo.get_symbol info)
    )

let test_get_flags test_ctxt =
  test_function_info (fun info ->
      assert_equal [] (GIFunctionInfo.get_flags info)
    )

let test_get_property test_ctxt =
  test_function_info (fun info ->
      match GIFunctionInfo.get_property info with
      | None -> assert_equal true true
      | Some _ -> assert_equal_string "It should not " "returns something"
    )

let test_get_vfunc test_ctxt =
  test_function_info (fun info ->
      match GIFunctionInfo.get_vfunc info with
      | None -> assert_equal true true
      | Some _ -> assert_equal_string "It should not " "returns something"
    )

let tests =
  "GObject Introspection FunctionInfo tests" >:::
  [
    "GIFunctionInfo get symbol" >:: test_get_symbol;
    "GIFunctionInfo get flags" >:: test_get_flags;
    "GIFunctionInfo get property" >:: test_get_property;
    "GIFunctionInfo get vfunc" >:: test_get_vfunc
  ]
