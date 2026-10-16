# Database Setup Notes

## Object: ZSTUDENT

Create this as a client-dependent transparent table in SE11.

| Field | Suggested built-in type | Length | Decimals | Key |
|---|---|---:|---:|---:|
| MANDT | CLNT | 3 | — | Yes |
| STUDENT_ID | CHAR | 10 | — | Yes |
| STUDENT_NAME | CHAR | 40 | — | No |
| COURSE | CHAR | 30 | — | No |
| MARKS | DEC | 5 | 2 | No |

Recommended custom Dictionary objects:
- `ZDM_STUDENT_ID` domain and `ZDE_STUDENT_ID` data element
- `ZDM_STUDENT_NAME` domain and `ZDE_STUDENT_NAME` data element
- `ZDM_COURSE` domain and `ZDE_COURSE` data element
- `ZDM_MARKS` domain and `ZDE_MARKS` data element

Assign data elements to the table fields, maintain field labels, set technical settings, save, and activate. Use your SAP system's supported conventions and existing Dictionary objects where appropriate.
