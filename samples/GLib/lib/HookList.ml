open Ctypes
open Foreign

type t
let t_typ : t structure typ = structure "HookList"
let f_seq_id = field t_typ "seq_id" (uint64_t)
let f_hook_size = field t_typ "hook_size" (uint32_t)
let f_is_setup = field t_typ "is_setup" (uint32_t)
let f_dummy3 = field t_typ "dummy3" (ptr void)
let f_dummy = field t_typ "dummy" (Array.t_typ)

