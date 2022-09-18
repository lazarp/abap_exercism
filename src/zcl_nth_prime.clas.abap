CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS isprime
      IMPORTING
        in_number     TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.

ENDCLASS.


CLASS zcl_nth_prime IMPLEMENTATION.

  METHOD isprime.
    result = abap_true.
    IF in_number < 2.
      result = abap_false.
    ELSE.
      DATA(lv_number) = in_number - 1.
      WHILE lv_number >= 2.
        IF in_number MOD lv_number = 0.
          result = abap_false.
          EXIT.
        ENDIF.
        lv_number -= 1.
      ENDWHILE.
    ENDIF.
  ENDMETHOD.

  METHOD prime.
    DATA(lv_nth_prime) = 0.
    DATA(lv_number) = 0.
    IF input = 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    WHILE lv_nth_prime < input.
      IF me->isprime( lv_number ) IS NOT INITIAL.
        lv_nth_prime += 1.
      ENDIF.
      lv_number += 1.
    ENDWHILE.
    result = lv_number - 1.
  ENDMETHOD.


ENDCLASS.

