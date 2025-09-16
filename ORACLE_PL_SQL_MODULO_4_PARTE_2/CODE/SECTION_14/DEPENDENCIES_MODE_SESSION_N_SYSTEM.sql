/*
Because remote dependencies are not automatically tracked in data dictionaries,
there must be another way for the Oracle server to check if a remote procedure
has been invalidated.
*/

-- Can alter de dependency mode for the current session by using the ALTER SESSION command:
ALTER SESSION SET REMOTE_DEPENDENCIES_MODE = { SIGNATURE | TIMESTAMP };

-- Can alter the dependency mode system-wide after startup with the ALTER SYSTEM command:
ALTER SYSTEM SET REMOTE_DEPENDENCIES_MODE = { SIGNATURE | TIMESTAMP }
