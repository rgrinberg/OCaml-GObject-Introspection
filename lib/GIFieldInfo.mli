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

(** GIFieldInfo — Struct representing a struct or union field *)

open Ctypes

(** A GIFieldInfo struct represents a field of a struct (see GIStructInfo),
    union (see GIUnionInfo) or an object (see GIObjectInfo).
    The GIFieldInfo is fetched by calling
    GIStructInfo.get_field,
    GIUnionInfo.get_field
    or GIObjectInfo.get_field. A field has a size, type and a struct offset
    asssociated and a set of flags, which is currently
    GI_FIELD_IS_READABLE or GI_FIELD_IS_WRITABLE.*)
type t
val fieldinfo : t structure typ

(** Flags for a GIFieldInfo. *)
type flags =
  | Is_readable (** field is readable. *)
  | Is_writable (** field is writable. *)

(** Obtain the flags for this GIFieldInfo. See GIFieldInfo.flags for possible
    flag values. *)
val get_flags:
  t structure ptr -> flags list

(** Obtain the offset in bits of the field member, this is relative to the
    beginning of the struct or union. *)
val get_offset:
  t structure ptr -> int

(** Obtain the size in bits of the field member, this is how much space you
    need to allocate to store the field. *)
val get_size:
  t structure ptr -> int

(** Obtain the type of a field as a GITypeInfo. *)
val get_type:
  t structure ptr -> GITypeInfo.t structure ptr

(*
   gboolean	g_field_info_get_field ()
   gboolean	g_field_info_set_field ()
 *)

(** Just cast OCaml Ctypes base info to field info. *)
val cast_from_baseinfo:
  GIBaseInfo.t structure ptr -> t structure ptr

(** Just cast OCaml Ctypes field info to base info *)
val cast_to_baseinfo:
  t structure ptr -> GIBaseInfo.t structure ptr

(** Add unref of the C underlying structure whith Gc.finalise. *)
val add_unref_finaliser:
  t structure ptr -> t structure ptr

(** Return a GIFieldInfo.t from a GIBaseInfo.t, the underlying C structure
    ref count is increased and the value is Gc.finalis"ed" with
    GIBaseInfo.baseinfo_unref. *)
val from_baseinfo:
  GIBaseInfo.t structure ptr -> t structure ptr

(** Return a GIBaseInfo.t from a GIFieldInfo, the underlying C structure
    ref count is increased and the value is Gc.finalis"ed" with
    GIBaseInfo.baseinfo_unref. *)
val to_baseinfo:
  t structure ptr -> GIBaseInfo.t structure ptr
