/*
ALL -> Enable three categories
SEVERE -> Unexpected behavior or wrong results when executed
PERFORMANCE -> Code that cause the execution speed to be slow
INFORMATIONAL -> Other poor coding practices
*/

ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:ALL';
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:PERFORMANCE';

/*
In this example, the first parameter enables all three categories, 
and the second disables the SEVERE category, leaving the PERFORMANCE and 
INFORMATIONAL categories enabled.
*/

ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:ALL', 'DISABLE:SEVERE';

-----------------------

ALTER SESSION SET PLSQL_WARNINGS = 'DISABLE:ALL';
...
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:PERFORMANCE';
...
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:SEVERE';
...
ALTER SESSION SET PLSQL_WARNINGS =
'ENABLE:ALL','DISABLE:SEVERE';
...
ALTER SESSION SET PLSQL_WARNINGS =
'DISABLE:SEVERE','ENABLE:ALL'