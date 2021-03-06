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

let namespace = "Gdk"
let repo = GIRepository.get_default ()
let typelib = GIRepository.require repo namespace ()
let object_name = "Display"

let test_from_baseinfo test_ctxt =
  match GIRepository.find_by_name repo namespace object_name with
  | None -> assert_equal_string object_name "No base info found"
  | Some (base_info) -> assert_equal_boolean true (
      match GIBaseInfo.get_type base_info with
      | GIBaseInfo.Object -> true
      | _ -> false )

let get_object_info () =
  match GIRepository.find_by_name repo namespace object_name with
  | None -> None
  | Some (base_info) ->
    match GIBaseInfo.get_type base_info with
    | GIBaseInfo.Object -> let object_info = GIObjectInfo.from_baseinfo base_info in
      Some object_info
    | _ -> None

let object_test fn =
  match get_object_info () with
  | None -> assert_equal_string object_name "No base info found"
  | Some (info) -> fn info

let test_get_abstract test_ctxt =
  object_test (fun info ->
      let is_abstract = GIObjectInfo.get_abstract info in
      assert_equal_boolean false is_abstract
    )

let test_get_fundamental test_ctxt =
  object_test (fun info ->
      let is_fundamental = GIObjectInfo.get_fundamental info in
      assert_equal_boolean false is_fundamental
    )

let test_get_parent test_ctxt =
  object_test (fun info ->
      let parent = GIObjectInfo.get_parent info in
      match GIBaseInfo.get_name parent with
      | None -> assert_equal_string "It should have " "a name"
      | Some parent_name -> assert_equal_string "Object" parent_name
    )

let test_get_type_name test_ctxt =
  object_test (fun info ->
      let type_name = GIObjectInfo.get_type_name info in
      assert_equal_string "GdkDisplay" type_name
    )

let test_get_type_init test_ctxt =
  object_test (fun info ->
      let type_init = GIObjectInfo.get_type_init info in
      assert_equal_string "gdk_display_get_type" type_init
    )

let test_get_n_constants test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_constants info in
      assert_equal_int 0 n
    )

let test_get_n_fields test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_fields info in
      assert_equal_int 0 n
    )

let test_get_n_interfaces test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_interfaces info in
      assert_equal_int 0 n
    )

let test_get_n_methods test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_methods info in
      if is_travis then assert_equal_int 41 n
      else assert_equal_int 48 n
    )

let test_get_method test_ctxt =
  object_test (fun info ->
      let m = GIObjectInfo.get_method info 0 in
      let m_name = GIFunctionInfo.get_symbol m in
      assert_equal_string "gdk_display_get_default" m_name
    )

let test_find_method test_ctxt =
  object_test (fun info ->
      let m_name = "get_default" in
      match GIObjectInfo.find_method info m_name with
      | None -> assert_equal_string "It should find " "a method"
      | Some info' -> let symbol = GIFunctionInfo.get_symbol info' in
        assert_equal_string ("gdk_display_" ^ m_name) symbol
    )

let test_get_n_properties test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_properties info in
      assert_equal_int 0 n
    )

let test_get_n_signals test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_signals info in
      if is_travis then assert_equal_int 2 n
      else assert_equal_int 6 n
    )

let test_get_n_vfuncs test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_vfuncs info in
      assert_equal_int 0 n
    )

let test_get_class_struct test_ctxt =
  object_test (fun info ->
      match GIObjectInfo.get_class_struct info with
      | None -> assert_equal_boolean true true
      | Some info' -> let is_struct = GIStructInfo.is_gtype_struct info' in
        assert_equal_boolean true is_struct
    )

let namespace = "Gtk"
let repo = GIRepository.get_default ()
let typelib = GIRepository.require repo namespace ()
let object_name = "Window"

let test_gtk_window_from_baseinfo test_ctxt =
  match GIRepository.find_by_name repo namespace object_name with
  | None -> assert_equal_string object_name "No base info found"
  | Some (base_info) -> assert_equal_boolean true (
      match GIBaseInfo.get_type base_info with
      | GIBaseInfo.Object -> true
      | _ -> false )

let get_object_info () =
  match GIRepository.find_by_name repo namespace object_name with
  | None -> None
  | Some (base_info) ->
    match GIBaseInfo.get_type base_info with
    | GIBaseInfo.Object -> let object_info = GIObjectInfo.from_baseinfo base_info in
      Some object_info
    | _ -> None

let object_test fn =
  match get_object_info () with
  | None -> assert_equal_string object_name "No base info found"
  | Some (info) -> fn info

let test_gtk_window_get_abstract test_ctxt =
  object_test (fun info ->
      let is_abstract = GIObjectInfo.get_abstract info in
      assert_equal_boolean false is_abstract
    )

let test_gtk_window_get_fundamental test_ctxt =
  object_test (fun info ->
      let is_fundamental = GIObjectInfo.get_fundamental info in
      assert_equal_boolean false is_fundamental
    )

let test_gtk_window_get_parent test_ctxt =
  object_test (fun info ->
      let parent = GIObjectInfo.get_parent info in
      match GIBaseInfo.get_name parent with
      | None -> assert_equal_string "It should have " "a name"
      | Some parent_name -> assert_equal_string "Bin" parent_name
    )

let test_gtk_window_get_type_name test_ctxt =
  object_test (fun info ->
      let type_name = GIObjectInfo.get_type_name info in
      assert_equal_string "GtkWindow" type_name
    )

let test_gtk_window_get_type_init test_ctxt =
  object_test (fun info ->
      let type_init = GIObjectInfo.get_type_init info in
      assert_equal_string "gtk_window_get_type" type_init
    )

let test_gtk_window_get_n_constants test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_constants info in
      assert_equal_int 0 n
    )

let test_gtk_window_get_n_fields test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_fields info in
      assert_equal_int 2 n
    )

let test_gtk_window_get_n_interfaces test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_interfaces info in
      assert_equal_int 2 n
    )

let test_gtk_window_get_interface test_ctxt =
   object_test (fun info ->
      let info' = GIObjectInfo.get_interface info 0 in
      let base_info' = GIInterfaceInfo.to_baseinfo info' in
      match GIBaseInfo.get_name base_info' with
      | None -> assert_equal_string "It should have" " a name"
      | Some interface_name -> assert_equal_string "ImplementorIface" interface_name
    )

let test_gtk_window_get_n_methods test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_methods info in
      if is_travis then assert_equal_int 115 n
      else assert_equal_int 119 n
    )

let test_gtk_window_get_method test_ctxt =
  object_test (fun info ->
      let m = GIObjectInfo.get_method info 0 in
      let m_name = GIFunctionInfo.get_symbol m in
      assert_equal_string "gtk_window_new" m_name
    )

let test_gtk_window_find_method test_ctxt =
  object_test (fun info ->
      let m_name = "new" in
      match GIObjectInfo.find_method info m_name with
      | None -> assert_equal_string "It should find " "a method"
      | Some info' -> let symbol = GIFunctionInfo.get_symbol info' in
        assert_equal_string ("gtk_window_" ^ m_name) symbol
    )

let test_gtk_window_get_n_properties test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_properties info in
      if is_travis then assert_equal_int 32 n
      else assert_equal_int 33 n
    )

let test_gtk_window_get_property test_ctxt =
  object_test (fun info ->
      let prop = GIObjectInfo.get_property info 0 in
      let base_prop = GIPropertyInfo.to_baseinfo prop in
      match GIBaseInfo.get_name base_prop with
      | None -> assert_equal_string "It should have " "a name"
      | Some name -> assert_equal_string "accept-focus" name
    )

let test_gtk_window_get_n_signals test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_signals info in
      if is_travis then assert_equal_int 4 n
      else assert_equal_int 5 n
    )

let test_gtk_window_get_signal test_ctxt =
  object_test (fun info ->
      let info' = GIObjectInfo.get_signal info 0 in
      let base_info = GISignalInfo.to_baseinfo info' in
      match GIBaseInfo.get_name base_info with
      | None -> assert_equal_string "It should have " "a name"
      | Some name -> assert_equal_string "activate-default" name
    )

let test_gtk_window_find_signal test_ctxt =
  object_test (fun info ->
      let signal_name = "activate-default" in
      match GIObjectInfo.find_signal info signal_name with
      | None -> assert_equal_string "It should have" " a signal"
      | Some info' -> let base_info = GISignalInfo.to_baseinfo info' in
        match GIBaseInfo.get_name base_info with
        | None -> assert_equal_string "It should have " "a name"
        | Some name -> assert_equal_string signal_name name
    )

let test_gtk_window_get_n_vfuncs test_ctxt =
  object_test (fun info ->
      let n = GIObjectInfo.get_n_vfuncs info in
      if is_travis then assert_equal_int 4 n
      else assert_equal_int 5 n
    )

let test_gtk_window_get_vfunc test_ctxt =
  object_test (fun info ->
      let info' = GIObjectInfo.get_vfunc info 0 in
      let base_info = GIVFuncInfo.to_baseinfo info' in
      match GIBaseInfo.get_name base_info with
      | None -> assert_equal_string "It should have " "a name"
      | Some name -> assert_equal_string "activate_default" name
    )

let test_gtk_window_find_vfunc test_ctxt =
  object_test (fun info ->
      let vfunc_name = "activate_default" in
      match GIObjectInfo.find_vfunc info vfunc_name with
      | None -> assert_equal_string object_name "No base info found"
      | Some info' -> let base_info = GIVFuncInfo.to_baseinfo info' in
        match GIBaseInfo.get_name base_info with
        | None -> assert_equal_string "It should have " "a name"
        | Some name -> assert_equal_string name vfunc_name
    )

let test_gtk_window_find_vfunc_using_interfaces test_ctxt =
  object_test (fun info ->
      let vfunc_name = "activate_default" in
      let (vfunc, implementor) =
        GIObjectInfo.find_vfunc_using_interfaces info vfunc_name in
      let _ = ( match implementor with
          | None -> assert_equal true true
          | Some info_implementor ->
            let base_info = GIObjectInfo.to_baseinfo info_implementor in
            match GIBaseInfo.get_name base_info with
            | None -> assert_equal_string "It should " "have a name"
            | Some name -> assert_equal_string "Window" name
        )
      in match vfunc with
      | None -> assert_equal_string "It should return " " a function info"
      | Some info' -> let base_info = GIVFuncInfo.to_baseinfo info' in
        match GIBaseInfo.get_name base_info with
        | None -> assert_equal_string "It should have " "a name"
        | Some name -> assert_equal_string name vfunc_name
     )


let test_gtk_window_get_class_struct test_ctxt =
  object_test (fun info ->
      match GIObjectInfo.get_class_struct info with
      | None -> assert_equal_boolean false true
      | Some info' -> let is_struct = GIStructInfo.is_gtype_struct info' in
        assert_equal_boolean true is_struct
    )

let test_gtk_window_find_method_using_interfaces test_ctxt =
  object_test (fun info ->
      let method_name = "set_title" in
      let (meth, implementor) =
        GIObjectInfo.find_method_using_interfaces info method_name in
      let _ = ( match implementor with
          | None -> assert_equal true true
          | Some info_implementor ->
            let base_info = GIObjectInfo.to_baseinfo info_implementor in
            match GIBaseInfo.get_name base_info with
            | None -> assert_equal_string "It should " "have a name"
            | Some name -> assert_equal_string "Window" name
        )
      in match meth with
      | None -> assert_equal_string "It should return " " a function info"
      | Some info' -> let symbol = GIFunctionInfo.get_symbol info' in
        assert_equal_string ("gtk_window_" ^ method_name) symbol
     )

let test_gtk_window_get_ref_function test_ctxt =
  object_test (fun info ->
      match GIObjectInfo.get_ref_function info with
      | None -> assert_equal true true
      | Some _ -> assert_equal_string "It should not " "have any ref function"
    )

let test_gtk_window_get_unref_function test_ctxt =
  object_test (fun info ->
      match GIObjectInfo.get_unref_function info with
      | None -> assert_equal true true
      | Some _ -> assert_equal_string "It should not " "have any ref function"
    )

let test_gtk_window_get_set_value_function test_ctxt =
  object_test (fun info ->
      match GIObjectInfo.get_set_value_function info with
      | None -> assert_equal true true
      | Some _ -> assert_equal_string "It should not " "have any set value function"
    )

let test_gtk_window_get_get_value_function test_ctxt =
  object_test (fun info ->
      match GIObjectInfo.get_get_value_function info with
      | None -> assert_equal true true
      | Some _ -> assert_equal_string "It should not " "have any set value function"
    )

let tests =
  "GObject Introspection ObjectInfo tests" >:::
  [
    "GIObjectInfo from baseinfo" >:: test_from_baseinfo;
    "GIObjectInfo get abstract" >:: test_get_abstract;
    "GIObjectInfo get fundamental" >:: test_get_fundamental;
    "GIObjectInfo get parent" >:: test_get_parent;
    "GIObjectInfo get type name" >:: test_get_type_name;
    "GIObjectInfo get type init" >:: test_get_type_init;
    "GIObjectInfo get n constants" >:: test_get_n_constants;
    "GIObjectInfo get n fields" >:: test_get_n_fields;
    "GIObjectInfo get n interfaces" >:: test_get_n_interfaces;
    "GIObjectInfo get n methods" >:: test_get_n_methods;
    "GIObjectInfo get method" >:: test_get_method;
    "GIObjectInfo find method" >:: test_find_method;
    "GIObjectInfo get n properties" >:: test_get_n_properties;
    "GIObjectInfo get n signals" >:: test_get_n_signals;
    "GIObjectInfo GtkWindow get n vfuncs" >:: test_get_n_vfuncs;
    "GIObjectInfo GtkWindow get class struct" >:: test_get_class_struct;
    "GIObjectInfo GtkWindow from baseinfo" >:: test_gtk_window_from_baseinfo;
    "GIObjectInfo GtkWindow get abstract" >:: test_gtk_window_get_abstract;
    "GIObjectInfo GtkWindow get fundamental" >:: test_gtk_window_get_fundamental;
    "GIObjectInfo GtkWindow get parent" >:: test_gtk_window_get_parent;
    "GIObjectInfo GtkWindow get type name" >:: test_gtk_window_get_type_name;
    "GIObjectInfo GtkWindow get type init" >:: test_gtk_window_get_type_init;
    "GIObjectInfo GtkWindow get n constants" >:: test_gtk_window_get_n_constants;
    "GIObjectInfo GtkWindow get n fields" >:: test_gtk_window_get_n_fields;
    "GIObjectInfo GtkWindow get n interfaces" >:: test_gtk_window_get_n_interfaces;
    "GIObjectInfo GtkWindow get interface" >:: test_gtk_window_get_interface;
    "GIObjectInfo GtkWindow get n methods" >:: test_gtk_window_get_n_methods;
    "GIObjectInfo GtkWindow get method" >:: test_gtk_window_get_method;
    "GIObjectInfo GtkWindow find method" >:: test_gtk_window_find_method;
    "GIObjectInfo GtkWindow get n properties" >:: test_gtk_window_get_n_properties;
    "GIObjectInfo GtkWindow get n signals" >:: test_gtk_window_get_n_signals;
    "GIObjectInfo GtkWindow get signal" >:: test_gtk_window_get_signal;
    "GIObjectInfo GtkWindow find signal" >:: test_gtk_window_find_signal;
    "GIObjectInfo GtkWindow get n vfuncs" >:: test_gtk_window_get_n_vfuncs;
    "GIObjectInfo GtkWindow get vfunc" >:: test_gtk_window_get_vfunc;
    "GIObjectInfo GtkWindow find vfunc" >:: test_gtk_window_find_vfunc;
    "GIObjectInfo GtkWindow find vfunc using interfaces" >:: test_gtk_window_find_vfunc_using_interfaces;
    "GIObjectInfo GtkWindow get class struct" >:: test_gtk_window_get_class_struct;
    "GIObjectInfo GtkWindow get property" >:: test_gtk_window_get_property;
    "GIObjectInfo GtkWindow find method using interfaces" >:: test_gtk_window_find_method_using_interfaces;
    "GIObjectInfo GtkWindow get ref function" >:: test_gtk_window_get_ref_function;
    "GIObjectInfo GtkWindow get unref function" >:: test_gtk_window_get_unref_function;
    "GIObjectInfo GtkWindow get set value function" >:: test_gtk_window_get_set_value_function;
    "GIObjectInfo GtkWindow get get value function" >:: test_gtk_window_get_get_value_function
  ]
