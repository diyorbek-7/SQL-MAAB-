SELECT 
    d.name AS database_name,
    s.name AS schema_name,
    t.name AS table_name,
    c.name AS column_name,
    c.system_type_id AS column_data_type
FROM 
    sys.databases d
    JOIN sys.tables t ON d.database_id = t.database_id
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    JOIN sys.columns c ON t.object_id = c.object_id
WHERE 
    d.name NOT IN ('master', 'tempdb', 'model', 'msdb');