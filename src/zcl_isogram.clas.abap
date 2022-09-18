CLASS zcl_isogram DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS is_isogram
      IMPORTING
        VALUE(phrase) TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA alphabet TYPE string.
ENDCLASS.



CLASS zcl_isogram IMPLEMENTATION.

  METHOD is_isogram.
    " add solution here
    me->alphabet = |abcdefghijklmnopqrstuvwxyz|.

    result = abap_true.
    DATA(lv_phrase) = phrase.
    DATA(lv_index) = 0.
    WHILE lv_index < strlen( phrase ).
      TRANSLATE lv_phrase to lower case.
      DATA(current_char) = lv_phrase+lv_index(1).
      FIND current_char IN alphabet. "is it a valid letter?
      IF sy-subrc IS INITIAL.
        REPLACE current_char IN lv_phrase WITH ''.
        FIND current_char IN lv_phrase.
        IF sy-subrc IS INITIAL. "is there one more occurrence of this char?
          result = abap_false.
          EXIT.
        ENDIF.
      ENDIF.
      lv_phrase = phrase.
      lv_index += 1.
    ENDWHILE.

  ENDMETHOD.

ENDCLASS.
