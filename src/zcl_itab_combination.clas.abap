CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas             TYPE alphas
        nums               TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.

CLASS zcl_itab_combination IMPLEMENTATION.

  METHOD perform_combination.
    loop at alphas assigning field-symbol(<lwa_alphas>).
    APPEND INITIAL LINE TO combined_data assigning field-symbol(<lwa_combined>).
    read table nums index sy-tabix assigning field-symbol(<lwa_nums>).
      if sy-subrc is initial.
        <lwa_combined>-colx = |{ <lwa_alphas>-cola }| & |{ <lwa_nums>-col1 }|.
        <lwa_combined>-coly = |{ <lwa_alphas>-colb }| & |{ <lwa_nums>-col2 }|.
        <lwa_combined>-colz = |{ <lwa_alphas>-colc }| & |{ <lwa_nums>-col3 }|.
      endif.
    endloop.
  ENDMETHOD.

ENDCLASS.
