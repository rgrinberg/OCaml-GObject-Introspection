#include "conversions.h"

value
c_null_term_array_of_strings_to_ocaml_strings_list (char **strings)
{

    value cons;
    value cli;
    char *str = NULL;
    char **ptr = strings;
    cli = Val_emptylist;

    for ( ; *ptr != NULL; ptr++ )
    {
        str = *ptr;
        cons = caml_alloc (2, 0);

        Store_field (cons, 0, caml_copy_string(str));  // head
        Store_field (cons, 1, cli);                    // tail

        cli = cons;
    }

    return cli;
}

value
gslist_of_strings_to_ocaml_strings_list (GSList *list)
{

    GSList *iterator = NULL;
    value cons;
    value cli;
    char *str = NULL;
    cli = Val_emptylist;

    for (iterator = list; iterator; iterator = iterator->next) {
        str = iterator->data;
        cons = caml_alloc (2, 0);

        Store_field (cons, 0, caml_copy_string(str));  // head
        Store_field (cons, 1, cli);                    // tail

        cli = cons;
    }

    return cli;
}

value
glist_of_strings_to_ocaml_strings_list (GList *list)
{

    GList *iterator = NULL;
    value cons;
    value cli;
    char *str = NULL;
    cli = Val_emptylist;

    for (iterator = list; iterator; iterator = iterator->next) {
        str = iterator->data;
        cons = caml_alloc (2, 0);

        Store_field (cons, 0, caml_copy_string(str));  // head
        Store_field (cons, 1, cli);                    // tail

        cli = cons;
    }

    return cli;
}

value
val_some( value v )
{
    CAMLparam1 (v);
    CAMLlocal1 (some);
    some = caml_alloc (1, 0);
    Store_field (some, 0, v);

    CAMLreturn (some);
}

void
raise_gerror_to_ocaml_failure_exception (GError *error)
{
    if(error == NULL)
        return;

    caml_failwith (error->message);
    g_clear_error (&error); // TODO : is it needed since we rise an exception ?
}