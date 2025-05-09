SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    c.name AS ColumnName,
    ty.name AS ColumnType
FROM 
    sys.indexes i
INNER JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
INNER JOIN 
    sys.tables t ON i.object_id = t.object_id
INNER JOIN 
    sys.types ty ON c.user_type_id = ty.user_type_id
WHERE 
    i.is_primary_key = 0 AND i.is_unique_constraint = 0
ORDER BY 
    t.name, i.name;
-----------
DECLARE @HTML NVARCHAR(MAX) = '
<style>
    table {
        border-collapse: collapse;
        width: 100%;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #04AA6D;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
</style>
<h2>Index Metadata Report</h2>
<table>
<tr><th>Table Name</th><th>Index Name</th><th>Index Type</th><th>Column Name</th><th>Column Type</th></tr>';

SELECT @HTML += 
    '<tr><td>' + t.name + '</td><td>' + i.name + '</td><td>' + i.type_desc +
    '</td><td>' + c.name + '</td><td>' + ty.name + '</td></tr>'
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t ON i.object_id = t.object_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE i.is_primary_key = 0 AND i.is_unique_constraint = 0;

SET @HTML += '</table>';
---------------
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'GmailProfile',
    @recipients = 'azatovhikmatyor@outlook.com;dilmurodovsohibjon@gmail.com',
    @subject = 'SQL Server Index Report',
    @body = @HTML,
    @body_format = 'HTML';



