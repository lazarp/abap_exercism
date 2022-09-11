CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
* add solution here
  DATA lv_you TYPE string.
  IF input IS INITIAL.
    lv_you = 'you'.
  ELSE.
    lv_you = input.
  ENDIF.
  result = |One for { lv_you }, one for me.|.
  ENDMETHOD.

ENDCLASS.
