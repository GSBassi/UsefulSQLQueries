
SELECT x.[value], count(*) as count
FROM Attachments as a
CROSS APPLY OPENJSON(JSON_QUERY(ImageData,'$.description.tags')) AS x
WHERE imagedata is not null and imagedata not like '%invalid%'
group by value
 

 select imagedata,attachments.DateLastModified 
 from attachments 
 inner join logentry on Attachments.LogEntryGUID=LogEntry.LogEntryGUID 
 inner join episode on LogEntry.episodeGUID=episode.episodeGUID 
 inner join project on episode.projectGUID=project.projectGUID 
 where  imagedata is  null and project.CreatedByOrganization='guardian' order by attachments.DateLastModified desc

 select CreatedByOrganization, count(*) from project group by CreatedByOrganization  


 select LogEntryGUID,imagedata  from attachments  where  imagedata is not null 

 

declare @RowCnt int
declare @MaxRows int

declare @tmpLogGUID as nvarchar(1000)
declare @tmpImageData as nvarchar(1000)
declare @tmpSQL as nvarchar(1000)

select @RowCnt = 1

declare @Import table (rownum int IDENTITY (1, 1) Primary key NOT NULL ,LogEntryGUID uniqueidentifier,imagedata nvarchar(4000))
insert into @Import (LogEntryGUID,imagedata) select LogEntryGUID,imagedata  from attachments  where  imagedata is not null 

select @MaxRows=count(*) from @Import
while @RowCnt <= @MaxRows
begin
   select @tmpLogGUID=LogEntryGUID from @Import where rownum = @RowCnt 
   select @tmpImageData = imagedata from @Import where rownum = @RowCnt 

   set @tmpSQL = 'Update CoBRAClientData.Dbo.Attachments Set ImageData=''' +  @tmpImageData + ''' WHERE LogEntryGUID =N''' + @tmpLogGUID + ''''
   print @tmpSQL
   
   Set @RowCnt = @RowCnt + 1
end