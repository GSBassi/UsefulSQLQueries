DECLARE ObjectEntries CURSOR STATIC READ_ONLY FOR
SELECT  ObjectGUID FROM  dbo.[Object] 

DECLARE @objID uniqueidentifier

OPEN ObjectEntries

FETCH NEXT FROM ObjectEntries
INTO @objID

WHILE (@@FETCH_STATUS = 0) BEGIN
	IF (@objID IS NOT NULL) BEGIN
		execute Object_PerformAmazingAction @objID 
	END

	FETCH NEXT FROM ObjectEntries
	INTO @objID
END

DEALLOCATE ObjectEntries

select * from [Object]