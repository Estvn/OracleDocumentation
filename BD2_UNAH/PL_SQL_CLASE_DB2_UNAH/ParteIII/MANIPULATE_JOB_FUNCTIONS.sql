-- ALL THE FUNCTIONS TO MANIPULATE A JOB MUST TO BE EXECUTED INSIDE AN ANONYNOUS BLOCK.
--------------------------------------------------------------------------------------

BEGIN
    -- FUNCTION TO EXECUTE A JOB MANUALLY.
    DBMS_SCHEDULER.RUN_JOB(
        JOB_NAME => 'JOB_MAYUS_BRAND_NAME'
    );
END;

--------------------------------------------------------------------------------------

BEGIN
    -- FUNCTION TO DROP A JOB.
    DBMS_SCHEDULER.DROP_JOB(
        JOB_NAME => 'JOB_MAYUS_BRAND_NAME'
    );
END;

--------------------------------------------------------------------------------------

-- QUERY TO SEE THE CREATED JOB IN THE DB.
SELECT * FROM USER_SCHEDULER_JOBS;

-- QUERY TO SEE THE EXECUTED JOBS, AND IF THESE HAVE BEEN EXECUTED CORRECTLY.
SELECT JOB_NAME, LOG_DATE, STATUS FROM USER_SCHEDULER_JOB_LOG;
