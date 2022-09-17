CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS decode
      IMPORTING
        cipher_text       TYPE string
      RETURNING
        VALUE(plain_text) TYPE string .
    METHODS encode
      IMPORTING
        plain_text         TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA alphabet TYPE string.
    DATA numbers  TYPE string.

ENDCLASS.



CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
    me->alphabet = |abcdefghijklmnopqrstuvwxyz|.
    me->numbers  = |0123456789|.

    DATA(lv_input) = cipher_text.
    DATA(lv_msg_size) = strlen( lv_input ).
    DATA(lv_index) = 0.
    WHILE lv_index < lv_msg_size.
      DATA(current_char) = lv_input+lv_index(1).
      FIND current_char IN alphabet MATCH OFFSET DATA(lv_pos).
      IF sy-subrc IS INITIAL.
        DATA(offset) = strlen( alphabet ) - lv_pos - 1.
        DATA(decoded_char) = alphabet+offset(1).
        plain_text = |{ plain_text }{ decoded_char }|.
      ELSE.
        FIND current_char IN numbers.
        IF sy-subrc IS INITIAL.
          plain_text = |{ plain_text }{ current_char }|.
        ENDIF.
      ENDIF.
      lv_index += 1.
    ENDWHILE.

  ENDMETHOD.

  METHOD encode.

    me->alphabet = |abcdefghijklmnopqrstuvwxyz|.
    me->numbers  = |0123456789|.

    DATA(lv_input) = plain_text.
    TRANSLATE lv_input TO LOWER CASE.
    DATA(lv_msg_size) = strlen( lv_input ).
    DATA(lv_cipher_char_added) = 0.
    DATA(lv_index) = 0.
    WHILE lv_index < lv_msg_size.

      DATA(current_char) = lv_input+lv_index(1).
      FIND current_char IN alphabet MATCH OFFSET DATA(lv_pos).
      IF sy-subrc IS INITIAL.
        IF lv_cipher_char_added > 0 AND lv_cipher_char_added MOD 5 = 0.
          cipher_text = |{ cipher_text } |. "adding a blank space.
          "CONCATENATE lv_output ` ` INTO lv_output.
        ENDIF.
        DATA(offset) = strlen( alphabet ) - lv_pos - 1.
        DATA(encoded_char) = alphabet+offset(1).
        cipher_text = |{ cipher_text }{ encoded_char }|.
        "CONCATENATE lv_output encoded_char INTO lv_output.
        lv_cipher_char_added += 1.
      ELSE.
        FIND current_char IN numbers.
        IF sy-subrc IS INITIAL.
          IF lv_cipher_char_added > 0 AND lv_cipher_char_added MOD 5 = 0.
            cipher_text = |{ cipher_text } |. "adding a blank space.
            "CONCATENATE lv_output ` ` INTO lv_output.
          ENDIF.
          cipher_text = |{ cipher_text }{ current_char }|.
          "CONCATENATE lv_output current_char INTO lv_output.
          lv_cipher_char_added += 1.
        ENDIF.
      ENDIF.
      lv_index += 1.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.

