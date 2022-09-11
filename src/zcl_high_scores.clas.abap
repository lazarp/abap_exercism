CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    " add solution here
    result = me->scores_list.
  ENDMETHOD.

  METHOD latest.
    " add solution here
    "DESCRIBE TABLE me->scores_list LINES DATA(lv_lines).
    DATA(lv_lines) = LINES( me->scores_list ).
    READ TABLE me->scores_list INDEX lv_lines INTO DATA(lv_latest).
    IF SY-SUBRC IS INITIAL.
      result = lv_latest.
    ENDIF.
  ENDMETHOD.

  METHOD personalbest.
    " add solution here
    LOOP AT me->scores_list ASSIGNING FIELD-SYMBOL(<lv_score>).
      IF result < <lv_score>.
        result = <lv_score>.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD personaltopthree.
    " add solution here
    "TYPES:  BEGIN OF TY_SCORES,
             "" score TYPE i,
            "END OF TY_SCORES.
  DATA lt_scores  TYPE integertab.
  DATA lt_partial TYPE integertab.
  lt_partial = me->scores_list.
  SORT lt_partial BY TABLE_LINE DESCENDING.
  DATA(lv_index) = 1.
  DO 3 TIMES.
    READ TABLE lt_partial INDEX lv_index INTO DATA(lv_score).
    IF SY-SUBRC IS INITIAL.
      APPEND lv_score TO lt_scores.
    ENDIF.
    lv_index = lv_index + 1.
  ENDDO.
  result = lt_scores.

  ENDMETHOD.


ENDCLASS.
