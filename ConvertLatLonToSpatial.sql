USE [CoBRAClientData]
declare @RowCnt int
declare @MaxRows int
declare @entryID as uniqueidentifier
declare @entryLong as nvarchar(100)
declare @entryLat as nvarchar(100)
declare @tmpGeom as Geometry = null;

select @RowCnt = 1

declare @Import table (rownum int IDENTITY (1, 1) Primary key NOT NULL , EntryGUID uniqueidentifier, Lat decimal(12,6), Long decimal(12,6))
insert into @Import (entryGUID,Lat,Long) select entryGUID,Lat,Long from [entry] where (Lat is not null AND Long is not null) AND ( EntryGeometry.STAsText() like 'POINT%')

select @MaxRows=count(*) from @Import
while @RowCnt <= @MaxRows
begin
   select @entryID=entryGUID,@entryLong=Long,@entryLat=Lat from @Import where rownum = @RowCnt 
   set @tmpGeom=geometry::STGeomFromText('POINT (' + @entryLong + ' ' + @entryLat + ')',4326)
   
   update entry set entrygeometry = @tmpGeom,DateLastModified=getutcdate()  where entryguid=@entryID

   Set @RowCnt = @RowCnt + 1
end

select entrygeometry from [entry] where entrygeometry.STAsText() like 'POINT%' order by datecreated desc