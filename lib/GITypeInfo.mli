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

(** GITypeInfo — Struct representing a type *)

open Ctypes

(** GITypeInfo represents a type. You can retrieve a type info from an argument
    (see GIArgInfo), a function return value (see GIFunctionInfo), a field
    (see GIFieldInfo), a property (see GIPropertyInfo), a constant
    (see GIConstantInfo) or for a union discriminator (see GIUnionInfo).
    A type can either be a of a basic type which is a standard C primitive type
    or an interface type. For interface types you need to call
    GITypeInfo.get_interface to get a reference to the base info for that
    interface. *)
type t
val typeinfo : t structure typ

(** Obtain a string representation of type. *)
val to_string:
  t structure ptr -> string

(** Obtain if the type is passed as a reference.
    Note that the types of GI_DIRECTION_OUT and GI_DIRECTION_INOUT parameters
    will only be pointers if the underlying type being transferred is a pointer
    (i.e. only if the type of the C function’s formal parameter is a pointer to
    a pointer). *)
val is_pointer:
  t structure ptr -> bool

(** Obtain the type tag for the type. See GITypeTag for a list of type tags. *)
val get_tag:
  t structure ptr -> GITypes.tag

(** Obtain the array length of the type. The type tag must be a GIType.array or
    -1 will returned. *)
val get_array_length:
  t structure ptr -> int

(** Obtain the fixed array size of the type. The type tag must be a
    GIType.array or -1 will returned. *)
val get_array_fixed_size:
  t structure ptr -> int

(** Obtain if the last element of the array is NULL. The type tag must be a
    GIType.array  or FALSE will returned. *)
val is_zero_terminated:
  t structure ptr -> bool

(** Obtain the array type for this type. See GIArrayType for a list of possible
    values. If the type tag of this type is not array, None will be returned. *)
val get_array_type:
  t structure ptr -> GITypes.array_type option

(** Obtain the parameter type n .*)
val get_param_type:
  t structure ptr -> int -> t structure ptr

(** For types which have GITypes.Interface such as GObjects and boxed
    values, this function returns full information about the referenced type.
    You can then inspect the type of the returned GIBaseInfo to further query
    whether it is a concrete GObject, a GInterface, a structure, etc. using
    GIBaseInfo.get_type. *)
val get_interface:
  t structure ptr -> GIBaseInfo.t structure ptr option

(** Just cast OCaml Ctypes base info to typeinfo. *)
val cast_from_baseinfo:
  GIBaseInfo.t structure ptr -> t structure ptr

(** Just cast OCaml Ctypes typeinfo to base info *)
val cast_to_baseinfo:
  t structure ptr -> GIBaseInfo.t structure ptr

(** Add unref of the C underlying structure whith Gc.finalise. *)
val add_unref_finaliser:
  t structure ptr -> t structure ptr

(** Return a GITypeInfo.t from a GIBaseInfo.t, the underlying C structure
    ref count is increased and the value is Gc.finalis"ed" with
    GIBaseInfo.baseinfo_unref. *)
val from_baseinfo:
  GIBaseInfo.t structure ptr -> t structure ptr

(** Return a GIBaseInfo.t form a GITypeInfo, the underlying C structure
    ref count is increased and the value is Gc.finalis"ed" with
    GIBaseInfo.baseinfo_unref. *)
val to_baseinfo:
  t structure ptr -> GIBaseInfo.t structure ptr
