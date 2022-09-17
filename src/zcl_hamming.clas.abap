CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    DATA(strand1_length) = strlen( first_strand  ).
    DATA(strand2_length) = strlen( second_strand ).
    IF strand1_length <> strand2_length.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    DATA(lv_index) = 0.
    DATA(lv_hamming_distance) = 0.
    WHILE lv_index < strand1_length.
      IF first_strand+lv_index(1) <> second_strand+lv_index(1).
        lv_hamming_distance += 1.
      ENDIF.
      lv_index += 1.
    ENDWHILE.
    result = lv_hamming_distance.
  ENDMETHOD.

ENDCLASS.
