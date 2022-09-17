CLASS zcl_clock_without_dates DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.
    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.
    DATA t_hours   TYPE i.
    DATA t_minutes TYPE i.
    METHODS normalize.
    METHODS normalize_hours.
    METHODS normalize_minutes.
ENDCLASS.



CLASS zcl_clock_without_dates IMPLEMENTATION.
  METHOD normalize_hours.
    me->t_hours = me->t_hours MOD 24.
  ENDMETHOD.

  METHOD normalize_minutes.
    DATA(t_add_hours) = me->t_minutes DIV 60.
    me->t_minutes = me->t_minutes MOD 60.
    me->t_hours += t_add_hours.
  ENDMETHOD.

  METHOD normalize.
    IF me->t_minutes < 0 OR me->t_minutes >= 60.
      me->normalize_minutes( ).
    ENDIF.
    IF me->t_hours < 0 OR me->t_hours > 23.
      me->normalize_hours( ).
    ENDIF.
  ENDMETHOD.

  METHOD add.
* add solution here
    me->t_minutes += minutes.
    me->normalize( ).
  ENDMETHOD.


  METHOD constructor.
* add solution here
    me->t_hours   = hours.
    me->t_minutes = minutes.
    me->normalize( ).

  ENDMETHOD.


  METHOD get.
* add solution here
    DATA(str_hours)   = COND #( WHEN me->t_hours < 10 THEN |0{ me->t_hours }|
                                ELSE |{ me->t_hours }| ).
    DATA(str_minutes) = COND #( WHEN me->t_minutes < 10 THEN |0{ me->t_minutes }|
                                ELSE |{ me->t_minutes }| ).
    result = |{ str_hours }:{ str_minutes }|.
  ENDMETHOD.


  METHOD sub.
* add solution here
    me->t_minutes -= minutes.
    me->normalize( ).
  ENDMETHOD.
ENDCLASS.
