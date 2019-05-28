USE [CoBRAClientData]
declare @RowCnt int
declare @MaxRows int
declare @objID as uniqueidentifier

--start out a row count variable to use as a reference
select @RowCnt = 1
--declare temporary table to insert the important parts of the data you want changed
declare @Import table (rownum int IDENTITY (1, 1) Primary key NOT NULL , ObjectGUID uniqueidentifier)
--insert into temporary table the data, filtered by what you need
insert into @Import (ObjectGUID) select ObjectGUID from [Object]
--initialize maxRows
select @MaxRows=count(*) from @Import
--while loop to step through the rows
while @RowCnt <= @MaxRows
begin
   --get the objectGUID for this row
   select @objID=ObjectGUID from @Import where rownum = @RowCnt 
   --perform an action for that row in particular
   execute Object_PerformAmazingAction @objID 
   --increment the count
   Set @RowCnt = @RowCnt + 1
end

select * from [Object]