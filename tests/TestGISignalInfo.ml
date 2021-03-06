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

let namespace = "Gtk"
let repo = GIRepository.get_default ()
let typelib = GIRepository.require repo namespace ()
let object_name = "Window"
let signal_name = "activate-default"

let get_signal_info () =
  match GIRepository.find_by_name repo namespace object_name with
  | None -> None
  | Some (base_info) ->
    match GIBaseInfo.get_type base_info with
    | GIBaseInfo.Object -> (
        let object_info = GIObjectInfo.from_baseinfo base_info in
        match GIObjectInfo.find_signal object_info signal_name with
        | None -> None
        | Some info' -> Some info'
      )
    | _ -> None

let signal_test fn =
  match get_signal_info () with
  | None -> assert_equal_string object_name "No base info found"
  | Some (info) -> fn info

let test_true_stops_emit test_ctxt =
  signal_test (fun info ->
      let stops = GISignalInfo.true_stops_emit info in
      assert_equal_boolean false stops
    )

let test_get_flags test_ctxt =
  signal_test (fun info ->
      let flags = GISignalInfo.get_flags info in
      let rec check_flags = function
        | [] -> ()
        | f' :: q -> let _ = assert_equal ~printer:(fun f ->
            match f with
            | GISignalInfo.Run_first -> "Run_first"
            | GISignalInfo.Run_last -> "Run_last"
            | GISignalInfo.Run_cleanup -> "Run_cleanup"
            | GISignalInfo.No_recurse -> "No_recurse"
            | GISignalInfo.Detailed -> "Detailed"
            | GISignalInfo.Action -> "Action"
            | GISignalInfo.No_hooks -> "No_hooks"
            | GISignalInfo.Must_collect -> "Must_collect"
            | GISignalInfo.Deprecated -> "Deprecated"
          ) GISignalInfo.Run_first f' in check_flags q
      in check_flags flags
    )

let test_get_class_closure test_ctxt =
  signal_test (fun info ->
      match GISignalInfo.get_class_closure info with
      | None -> assert_equal_boolean true true
      | Some info' -> assert_equal_string "Class closure " " found"
    )

let tests =
  "GObject Introspection SignalInfo tests" >:::
  [
    "GISignalInfo true stops emit" >:: test_true_stops_emit;
    "GISignalInfo get flags" >:: test_get_flags;
    "GISingalInfo get class closure" >:: test_get_class_closure
  ]
