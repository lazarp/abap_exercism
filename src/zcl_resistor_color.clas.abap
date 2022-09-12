CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.
ENDCLASS.

CLASS zcl_resistor_color IMPLEMENTATION.

  METHOD resistor_color.
    DATA(lv_color_code) = color_code.
    TRANSLATE lv_color_code TO UPPER CASE.
    CASE lv_color_code.
      WHEN 'BLACK'.
        value = 0.
      WHEN 'BROWN'.
        value = 1.
      WHEN 'RED'.
        value = 2.
      WHEN 'ORANGE'.
        value = 3.
      WHEN 'YELLOW'.
        value = 4.
      WHEN 'GREEN'.
        value = 5.
      WHEN 'BLUE'.
        value = 6.
      WHEN 'VIOLET'.
        value = 7.
      WHEN 'GREY'.
        value = 8.
      WHEN 'WHITE'.
        value = 9.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
