REPORT zstudent_management.

PARAMETERS:
  p_add  RADIOBUTTON GROUP act DEFAULT 'X',
  p_disp RADIOBUTTON GROUP act,
  p_upd  RADIOBUTTON GROUP act,
  p_del  RADIOBUTTON GROUP act.

PARAMETERS:
  p_id     TYPE zstudent-student_id,
  p_name   TYPE zstudent-student_name,
  p_course TYPE zstudent-course,
  p_marks  TYPE zstudent-marks.

START-OF-SELECTION.

  DATA ls_student TYPE zstudent.

  IF p_add = 'X'.

    IF p_id IS INITIAL OR p_name IS INITIAL.
      MESSAGE 'Enter Student ID and Name' TYPE 'E'.
    ENDIF.

    IF p_marks < 0 OR p_marks > 100.
      MESSAGE 'Marks must be between 0 and 100' TYPE 'E'.
    ENDIF.

    CLEAR ls_student.
    ls_student-student_id   = p_id.
    ls_student-student_name = p_name.
    ls_student-course       = p_course.
    ls_student-marks        = p_marks.

    INSERT zstudent FROM @ls_student.

    IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
      MESSAGE 'Student added successfully' TYPE 'S'.
    ELSE.
      ROLLBACK WORK.
      MESSAGE 'Insert failed. Check for duplicate ID or table settings'
        TYPE 'E'.
    ENDIF.

  ELSEIF p_disp = 'X'.

    SELECT *
      FROM zstudent
      INTO TABLE @DATA(lt_students).

    IF lt_students IS INITIAL.
      MESSAGE 'No student records found' TYPE 'I'.
    ELSE.
      TRY.
          cl_salv_table=>factory(
            IMPORTING
              r_salv_table = DATA(lo_alv)
            CHANGING
              t_table      = lt_students ).

          lo_alv->display( ).

        CATCH cx_salv_msg.
          MESSAGE 'Unable to display student records' TYPE 'E'.
      ENDTRY.
    ENDIF.

  ELSEIF p_upd = 'X'.

    IF p_id IS INITIAL.
      MESSAGE 'Enter Student ID' TYPE 'E'.
    ENDIF.

    IF p_name IS INITIAL.
      MESSAGE 'Enter Student Name' TYPE 'E'.
    ENDIF.

    IF p_marks < 0 OR p_marks > 100.
      MESSAGE 'Marks must be between 0 and 100' TYPE 'E'.
    ENDIF.

    UPDATE zstudent
      SET student_name = @p_name,
          course       = @p_course,
          marks        = @p_marks
      WHERE student_id = @p_id.

    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
      MESSAGE 'Student updated successfully' TYPE 'S'.
    ELSE.
      ROLLBACK WORK.
      MESSAGE 'No record updated. Check Student ID' TYPE 'I'.
    ENDIF.

  ELSEIF p_del = 'X'.

    IF p_id IS INITIAL.
      MESSAGE 'Enter Student ID' TYPE 'E'.
    ENDIF.

    DELETE FROM zstudent
      WHERE student_id = @p_id.

    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
      MESSAGE 'Student deleted successfully' TYPE 'S'.
    ELSE.
      ROLLBACK WORK.
      MESSAGE 'Student ID not found' TYPE 'I'.
    ENDIF.

  ENDIF.
