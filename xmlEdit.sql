select * from organization
select orgxmldata from organization where orgxmldata not like '%<DefaultPage>~/EMISSARY/Dashboard/Index//597cbf6a-54a5-4b25-a77e-25cbe685c940</DefaultPage>%'

select orgxmldata from organization where orgxmldata like '%defaultpage%' and orgxmldata like '%defaultpage%' and orgxmldata not like '%~/EMISSARY/Dashboard/Index//597cbf6a-54a5-4b25-a77e-25cbe685c940%'


update organization
set orgxmldata.modify('replace value of (/Node/DefaultPage/text())[1] with "~/EMISSARY/Dashboard/Index//597cbf6a-54a5-4b25-a77e-25cbe685c940"')
where orgxmldata is not null