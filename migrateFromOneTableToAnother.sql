DECLARE @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10)
DECLARE @srcDB sysname;
DECLARE @newDB sysname;
DECLARE @oldSchema sysname;
DECLARE @newSchema sysname;

SET @srcDB = 'tmpccd';
SET @newDB = 'CoBRAClientData';
SET @oldSchema = 'dbo';
SET @newSchema = 'dbo';


SELECT N'INSERT INTO ' + QUOTENAME(@newDB) + N'.' + QUOTENAME(@newSchema) + N'.' + QUOTENAME(t.name) + N'(' + STUFF((SELECT N', ' + QUOTENAME(c.name) FROM sys.columns c WHERE c.object_id = t.object_id and c.name <> 'ClusterID' ORDER BY c.column_id FOR XML PATH(N'')), 1, 2, N'') + N'
) SELECT ' + STUFF((SELECT N', ' + QUOTENAME(c.name) FROM sys.columns c WHERE c.object_id = t.object_id and c.name <> 'ClusterID' ORDER BY c.column_id FOR XML PATH(N'')), 1, 2, N'') + N'
FROM ' + QUOTENAME(@srcDB) + N'.' + QUOTENAME(@oldSchema) + N'.' + QUOTENAME(t.name) + N' ' 
FROM sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @oldSchema
ORDER BY t.name;