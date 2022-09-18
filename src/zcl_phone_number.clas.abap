CLASS zcl_phone_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA numbers TYPE string.

    METHODS remove_symbols
      IMPORTING
        number        TYPE string
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.


CLASS zcl_phone_number IMPLEMENTATION.

  METHOD remove_symbols.
    DATA(lv_index) = 0.
    WHILE lv_index < strlen( number ).
      DATA(current_char) = number+lv_index(1).
      FIND current_char IN numbers.
      IF sy-subrc IS INITIAL.
        result = |{ result }{ current_char }|.
      ENDIF.
      lv_index += 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD clean.
    me->numbers = |0123456789|.

    DATA(lv_index) = 0.
    DATA(lv_number)  = me->remove_symbols( number ).
    DATA(lv_num_len) = strlen( lv_number ).



    IF lv_num_len > 11.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    IF lv_num_len = 11.
      IF lv_number+0(1) = '1'.
        REPLACE '1' IN lv_number WITH ''.
      ELSE.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.
    ENDIF.


    WHILE lv_index < strlen( lv_number ).
      DATA(current_char) = lv_number+lv_index(1).
      FIND current_char IN numbers.
      IF sy-subrc IS INITIAL.
        IF lv_index = 0 OR lv_index =  3. "N digits
          IF current_char = 0 OR current_char = 1.
            RAISE EXCEPTION TYPE cx_parameter_invalid.
            EXIT.
          ENDIF.
        ENDIF.
        result = |{ result }{ current_char }|.
      ENDIF.
      lv_index += 1.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.

