open Ctypes
open Foreign

type t
let t_typ : t structure typ = structure "Once"
(* TODO Struct field Once : interface tag not implemented *)let f_retval = field t_typ "retval" (ptr void)

