CLASS zcl_leap DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS leap
      IMPORTING
        year          TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zcl_leap IMPLEMENTATION.

  METHOD leap.
* add solution here
    IF year MOD 4 = 0.
      result = ABAP_TRUE.
      IF year MOD 100 = 0.
        result = ABAP_FALSE.
        IF year MOD 400 = 0.
          result = ABAP_TRUE.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
