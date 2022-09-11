CLASS zcl_35_itab_basics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_type,
             group       TYPE group,
             number      TYPE i,
             description TYPE string,
           END OF initial_type,
           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY.
    METHODS fill_itab
      RETURNING
        VALUE(initial_data) TYPE itab_data_type.
    METHODS add_to_itab
      IMPORTING initial_data        TYPE itab_data_type
      RETURNING
                VALUE(updated_data) TYPE itab_data_type.
    METHODS sort_itab
      IMPORTING initial_data        TYPE itab_data_type
      RETURNING
                VALUE(updated_data) TYPE itab_data_type.
    METHODS search_itab
      IMPORTING initial_data        TYPE itab_data_type
      RETURNING
                VALUE(result_index) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_35_itab_basics IMPLEMENTATION.
  METHOD fill_itab.
    "add solution here
    DATA lwa_entry TYPE initial_type.
    lwa_entry-group = 'A'.
    lwa_entry-number = 10.
    lwa_entry-description = 'Group A-2'.
    APPEND lwa_entry TO initial_data.
    lwa_entry-group = 'B'.
    lwa_entry-number = 5.
    lwa_entry-description = 'Group B'.
    APPEND lwa_entry TO initial_data.
    lwa_entry-group = 'A'.
    lwa_entry-number = 6.
    lwa_entry-description = 'Group A-1'.
    APPEND lwa_entry TO initial_data.
    lwa_entry-group = 'C'.
    lwa_entry-number = 22.
    lwa_entry-description = 'Group C-1'.
    APPEND lwa_entry TO initial_data.
    lwa_entry-group = 'A'.
    lwa_entry-number = 13.
    lwa_entry-description = 'Group A-3'.
    APPEND lwa_entry TO initial_data.
    lwa_entry-group = 'C'.
    lwa_entry-number = 500.
    lwa_entry-description = 'Group C-2'.
    APPEND lwa_entry TO initial_data.

  ENDMETHOD.
  METHOD add_to_itab.
    updated_data = initial_data.
    DATA lwa_entry TYPE initial_type.
    lwa_entry-group = 'A'.
    lwa_entry-number = 19.
    lwa_entry-description = 'Group A-4'.
    APPEND lwa_entry TO updated_data.
  ENDMETHOD.
  METHOD sort_itab.
    updated_data = initial_data.
    "add solution here
    SORT updated_data BY group ASCENDING number DESCENDING.
  ENDMETHOD.
  METHOD search_itab.
    DATA(temp_data) = initial_data.
    "DATA sorted_data TYPE itab_data_type.
    "add solution here
    "sorted_data = me->sort_itab(temp_data).
    READ TABLE temp_data WITH KEY number = 6 TRANSPORTING NO FIELDS BINARY SEARCH.
    IF sy-subrc IS INITIAL.
      result_index = sy-tabix.
    ELSE.
      result_index = 0.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
