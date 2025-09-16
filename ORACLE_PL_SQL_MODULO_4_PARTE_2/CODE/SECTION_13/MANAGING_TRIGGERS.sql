-- Disable or re-enable a database trigger
ALTER TRIGGER trigger_name DISABLE | ENABLE

-- Disable or re-enable all triggers for a table 
ALTER TABLE DISABLE | ENABLE ALL TIRGGERS;

-- Recompile a trigger for a table 
ALTER TRIGGER trigger_name COMPILE;

-- Drops a trigger
DROP TRIGGER trigger_name