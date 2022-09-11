CLASS zcl_reverse_string DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_reverse_string IMPLEMENTATION.

  METHOD reverse_string.
    " Please complete the implementation of the reverse_string method
    DATA(lv_index) = STRLEN( input ) - 1.
    WHILE lv_index >= 0.
      result = |{ result }{ input+lv_index(1) }|.
      lv_index = lv_index - 1.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
