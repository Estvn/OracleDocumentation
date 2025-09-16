SELECT trigger_name, trigger_type, triggering_event, table_name, status, trigger_body
FROM USER_TRIGGERS
WHERE trigger_name = 'RESTRICT_SALARY';