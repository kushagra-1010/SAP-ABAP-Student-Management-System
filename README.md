# Student Management System — SAP ABAP

A beginner-friendly SAP ABAP project for practicing custom Dictionary tables, Open SQL CRUD operations, selection-screen parameters, validation, and ALV output.

## Features
- Create a student record
- Display all student records in ALV
- Update a student record by Student ID
- Delete a student record by Student ID
- Basic input validation and database result handling

## Requirements
- A classic SAP ABAP development system with SAP GUI transactions such as `SE11` and `SE38`
- Authorization to create and activate custom Dictionary objects and execute reports
- A development or sandbox client (do not test destructive operations in production)

> This is a learning project, not a production-ready application. Test and adapt it to your SAP release and local development standards.

## 1. Create the database table

In transaction `SE11`, create database table `ZSTUDENT`.

| Field | Suggested type | Key | Notes |
|---|---|---:|---|
| `MANDT` | `CLNT` / standard client element `MANDT` | Yes | Client field for a client-dependent table |
| `STUDENT_ID` | `CHAR`, length 10 | Yes | Student identifier |
| `STUDENT_NAME` | `CHAR`, length 40 | No | Student name |
| `COURSE` | `CHAR`, length 30 | No | Course name |
| `MARKS` | `DEC`, length 5, decimals 2 | No | Marks, intended range 0–100 |

For a proper Dictionary design, create domains and data elements for the custom fields (for example, `ZDM_STUDENT_ID` / `ZDE_STUDENT_ID`) and assign the data elements to the table fields. Maintain field labels, technical settings, save, and activate the table.

Make `MANDT` and `STUDENT_ID` the table key fields. In a client-dependent table, Open SQL normally handles client filtering and insertion for the current client.

## 2. Create the ABAP report

In `SE38`, create report `ZSTUDENT_MANAGEMENT`, paste the source from `src/zstudent_management.abap`, then syntax-check and activate it.

Press `F8` to run the report. Select an operation and enter the relevant values.

## 3. Test plan

1. **Add:** Student ID `S101`, Name `Rahul`, Course `AIML`, Marks `85.00`.
2. **Display:** Select Display and execute; the record should appear in ALV.
3. **Update:** Select Update, enter `S101`, and provide the new name/course/marks.
4. **Delete:** Select Delete and enter `S101`; verify it no longer appears.
5. **Duplicate key:** Try adding `S101` twice; the second insert should fail.
6. **Invalid marks:** Enter marks outside 0–100; validation should stop processing.
7. **Missing ID:** Leave Student ID blank for Update or Delete; validation should stop processing.

## Technical notes and limitations
- Update currently writes all non-key fields from the selection screen. Supply the intended values for every field when updating.
- The report uses a manually entered student ID rather than a number range.
- The program does not implement authorization checks or a confirmation dialog for deletion.
- `COMMIT WORK` and `ROLLBACK WORK` are shown for learning purposes. Production applications should follow the application's transaction/LUW design.
- The classic report/transaction workflow may not be available in ABAP Cloud. For ABAP Cloud, consider a RAP implementation with CDS view entities, behavior definitions, service binding, and a Fiori Elements UI.
