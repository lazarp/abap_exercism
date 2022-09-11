CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    TYPES: BEGIN OF scrabble,
              letter  TYPE string,
              s_value TYPE i,
           END OF scrabble.
    TYPES scrabble_data TYPE STANDARD TABLE OF scrabble WITH EMPTY KEY.
    DATA: lv_input_len TYPE i,
          lv_index     TYPE i,
          lv_char      TYPE c.
    DATA lt_scrabble TYPE scrabble_data.
    DATA(lv_input) = input.

    lt_scrabble = VALUE #(  ( letter = 'A, E, I, O, U, L, N, R, S, T' s_value = 1 )
                            ( letter = 'D, G'                         s_value = 2 )
                            ( letter = 'B, C, M, P'                   s_value = 3 )
                            ( letter = 'F, H, V, W, Y'                s_value = 4 )
                            ( letter = 'K'                            s_value = 5 )
                            ( letter = 'J, X'                         s_value = 8 )
                            ( letter = 'Q, Z'                         s_value = 10 ) ).
    IF lv_input IS INITIAL.
      result = 0.
    ELSE.
      TRANSLATE lv_input to UPPER CASE.
      lv_input_len = STRLEN( lv_input ).
      lv_index     = 0.
      WHILE lv_index < lv_input_len.
        lv_char  = lv_input+lv_index(1).
        LOOP AT lt_scrabble ASSIGNING FIELD-SYMBOL(<lwa_scrabble>).
          IF <lwa_scrabble>-letter CA lv_char. "CA = Contains Any
            result = result + <lwa_scrabble>-s_value.
            EXIT.
          ENDIF.
        ENDLOOP.
        lv_index = lv_index + 1.
      ENDWHILE.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
