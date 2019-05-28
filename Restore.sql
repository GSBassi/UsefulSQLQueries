use [master]

--lock the database down so you can restore w/out issues
ALTER DATABASE sourceDataBase SET SINGLE_USER WITH ROLLBACK IMMEDIATE
go
RESTORE DATABASE sourceDataBase FROM DISK='c:\temp\sourceDataBase_backup_2018_08_25_180414_7790678.bak' WITH FILE=1, 
MOVE 'sourceDataBase' to 'C:\Program Files\Microsoft SQL Server\MSSQL14.COBRASERVER\MSSQL\DATA\sourceDataBase.mdf',
MOVE 'sourceDataBase_log' to 'C:\Program Files\Microsoft SQL Server\MSSQL14.COBRASERVER\MSSQL\DATA\sourceDataBase_log.ldf',
REPLACE ,  NOUNLOAD,  REPLACE,  STATS = 10
go
--open the database back up
ALTER DATABASE sourceDataBase SET MULTI_USER WITH ROLLBACK IMMEDIATE
go

--take any users that had access to the database, and update them to the new server/system.
use [sourceDataBase]
EXEC sp_change_users_login 'Update_One', 'dbUser', 'dbUser'
GO
