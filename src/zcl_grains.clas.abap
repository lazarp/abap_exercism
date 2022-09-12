CLASS zcl_grains DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES type_result TYPE p LENGTH 16 DECIMALS 0.
    METHODS square
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
    METHODS total
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_grains IMPLEMENTATION.
  METHOD square.
    IF input <= 0 OR input > 64.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    result = 1.
    DO input - 1 TIMES.
      result = result * 2.
    ENDDO.
  ENDMETHOD.

  METHOD total.
    " add solution here
    DATA(lv_square_unit) = 1.
    DO 64 TIMES.
      result = result + me->square( lv_square_unit ).
      lv_square_unit = lv_square_unit + 1.
    ENDDO.
  ENDMETHOD.


ENDCLASS.
