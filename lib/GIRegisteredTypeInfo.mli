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

(**  GIRegisteredTypeInfo — Struct representing a struct with a GType. *)

open Ctypes
open Foreign

(** GIRegisteredTypeInfo represents an entity with a GType associated. Could be
    either a GIEnumInfo, GIInterfaceInfo, GIObjectInfo, GIStructInfo or a
    GIUnionInfo.
    A registered type info struct has a name and a type function. To get the
    name call GIRegisteredTypeInfo.get_type_name. Most users want to call
    GIRegisteredTypeInfo.get_g_type and don't worry about the rest of the
    details. *)

type t
val registeredtypeinfo : t structure typ

(** Obtain the type name of the struct within the GObject type system.
    This type can be passed to g_type_name() to get a #GType. *)
val get_type_name:
  t structure ptr -> string option

(** Obtain the gtype for this registered type or None which a special meaning.
    It means that either there is no type information associated with this @info or
    that the shared library which provides the type_init function for this
    @info cannot be called. *)
val get_g_type:
  t structure ptr -> GIRepository.gtype option

(** Obtain the type init function for info . The type init function is the
    function which will register the GType within the GObject type system.
    Usually this is not called by langauge bindings or applications, use
    GIRegisteredTypeInfo.get_g_type directly instead. *)
val get_type_init:
  t structure ptr -> string option

(** Just cast OCaml Ctypes base info to registeredtype info. *)
val cast_from_baseinfo:
  GIBaseInfo.t structure ptr -> t structure ptr

(** Just cast OCaml Ctypes registeredtype info to base info *)
val cast_to_baseinfo:
  t structure ptr -> GIBaseInfo.t structure ptr

(** Add unref of the C underlying structure whith Gc.finalise. *)
val add_unref_finaliser:
  t structure ptr -> t structure ptr

(** Return a GIRegisteredTypeInfo.t from a GIBaseInfo.t, the underlying C structure
    ref count is increased and the value is Gc.finalis"ed" with
    GIBaseInfo.baseinfo_unref. *)
val from_baseinfo:
  GIBaseInfo.t structure ptr -> t structure ptr

(** Return a GIBaseInfo.t from a GIRegisteredTypeInfo, the underlying C structure
    ref count is increased and the value is Gc.finalis"ed" with
    GIBaseInfo.baseinfo_unref. *)
val to_baseinfo:
  t structure ptr -> GIBaseInfo.t structure ptr
