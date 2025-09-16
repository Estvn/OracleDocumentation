-- Code will run slowly, but will work with older Oracle versions
ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 0;

-- Remove unnecesary code and exception of the compiled code.
ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 1;

-- Remove useless code and mode code to a different place to execute faster
ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 2;

-- Do all the previous, and compiled code of another subprogram 
-- is copied into the calling subprogram.
ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 3;
