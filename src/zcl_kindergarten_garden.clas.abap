CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.

    METHODS fill_students_list.
    METHODS get_student_number
      IMPORTING
        student    TYPE string
      RETURNING
        VALUE(num) TYPE i.
    METHODS get_plant_name
      IMPORTING
        character   TYPE string
      RETURNING
        VALUE(name) TYPE string.
ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.

  METHOD get_plant_name.
    CASE character.
      WHEN 'G'.
        name = 'grass'.
      WHEN 'C'.
        name = 'clover'.
      WHEN 'R'.
        name = 'radishes'.
      WHEN 'V'.
        name = 'violets'.
    ENDCASE.
  ENDMETHOD.

  METHOD fill_students_list.
    "APPEND 'Alice' TO me->students.
    me->students = VALUE string_table(
                                        ( |Alice|   )
                                        ( |Bob|     )
                                        ( |Charlie| )
                                        ( |David|   )
                                        ( |Eve|     )
                                        ( |Fred|    )
                                        ( |Ginny|   )
                                        ( |Harriet| )
                                        ( |Ileana|  )
                                        ( |Joseph|  )
                                        ( |Kincaid| )
                                        ( |Larry|   )
                                     ).
  ENDMETHOD.

  METHOD get_student_number.
    READ TABLE me->students WITH KEY table_line = student TRANSPORTING NO
    FIELDS.
    IF sy-subrc IS INITIAL.
      num = sy-tabix.
    ENDIF.
  ENDMETHOD.
  METHOD plants.
    " add solution here
    fill_students_list( ).
    DATA(student_number)  = get_student_number( student ).
    DATA(diagram_middle) = strlen( diagram ) / 2.
    DATA(first_plant_index)  = 2 * ( student_number - 1 ).
    DATA(second_plant_index) = first_plant_index + 1.
    DATA(third_plant_index)  = first_plant_index + diagram_middle + 1.
    DATA(fourth_plant_index) = third_plant_index + 1.


    DATA(first_plant)  = diagram+first_plant_index(1).
    DATA(second_plant) = diagram+second_plant_index(1).
    DATA(third_plant)  = diagram+third_plant_index(1).
    DATA(fourth_plant) = diagram+fourth_plant_index(1).

    results = VALUE string_table(
        ( get_plant_name( first_plant )  )
        ( get_plant_name( second_plant ) )
        ( get_plant_name( third_plant )  )
        ( get_plant_name( fourth_plant ) )
    ).




  ENDMETHOD.


ENDCLASS.

