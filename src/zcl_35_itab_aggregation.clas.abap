CLASS zcl_35_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_35_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    " add solution here
    DATA: LWA_RECORD TYPE aggregated_data_type.

    DATA: lv_group TYPE group.
    field-symbols: <lwa> TYPE initial_numbers_type,
                   <lwa_record> TYPE aggregated_data_type.

    "REFRESH aggregated_data.
    "CLEAR LWA_RECORD.
    DATA(lt_initial_numbers) = initial_numbers.
    SORT lt_initial_numbers BY group ASCENDING.
    LOOP AT lt_initial_numbers assigning <lwa>.
      IF SY-TABIX = 1.
        lv_group = <lwa>-group.
        IF lv_group is not initial.
          APPEND INITIAL LINE TO aggregated_data ASSIGNING <lwa_record>.
        ENDIF.
      ELSE.
        IF lv_group <> <lwa>-group.
          lv_group = <lwa>-group.
          APPEND INITIAL LINE TO aggregated_data ASSIGNING <lwa_record>.
        ENDIF.
      ENDIF.
      <lwa_record>-group   = <lwa>-group.
      <lwa_record>-count   = <lwa_record>-count + 1.
      <lwa_record>-sum     = <lwa_record>-sum + <lwa>-number.
      <lwa_record>-average = <lwa_record>-sum / <lwa_record>-count.
      IF <lwa_record>-count EQ 1.
        <lwa_record>-min = <lwa>-number.
        <lwa_record>-max = <lwa>-number.
      ELSE.
        IF <lwa_record>-min > <lwa>-number.
          <lwa_record>-min = <lwa>-number.
        ENDIF.
        IF <lwa_record>-max < <lwa>-number.
          <lwa_record>-max = <lwa>-number.
        ENDIF.
      ENDIF.
*    UNASSIGN <lwa>.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
