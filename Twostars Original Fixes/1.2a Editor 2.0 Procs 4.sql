--Editor 2.0 Procedures Part 4 1.298
--Can_SnoxD
--
--
USE KN_online
--
GO
CREATE procedure [dbo].[ITEMLERI_BUL] 
@StrUserID varchar(30)
AS
DECLARE
@length int, -- stritem uzunluğu
@i int, -- item'in stritem deki yeri
@dwid int, 
@dur int,
@duar int,
@StackSize1 int,
@Sira int,
@Row int,
@name varchar(100),
@extname varchar(100),
@ext int


set @i = 14*0+1
set @length = 601--401

select @row=count(*) from userdata where 
struserid=@StrUserID

delete from itemler where struserid=@StrUserID

if @row>0 
begin

WHILE @i < @length
Begin

Select 
@dwid=cast(cast(substring(cast(substring(strItem, 
@i,4) as varbinary(4)), 4, 
1)+substring(cast(substring(strItem, @i,4) as 
varbinary(4)), 3, 1)+substring(cast(substring(strItem, 
@i,4) as 
varbinary(4)), 2, 1)+substring(cast(substring(strItem, 
@i,4) as varbinary(4)), 1, 1) as varbinary(4)) as varbinary(4)),
@dur = cast(cast(cast( substring(strItem, @i+5, 1) as 
varbinary(1))+cast(substring(strItem, @i+4, 1) as 
varbinary(1)) as varbinary(2)) as smallint),
@StackSize1 = cast(cast(cast( substring(strItem, 
@i+7, 1) as varbinary(1))+cast(substring(strItem, 
@i+6, 1) as 
varbinary(1)) as varbinary(2)) as smallint),
@StrUserID = strUserID
From UserData
Where strUserID = @StrUserID



if @dwid is null
set @dwid=0
if @stacksize1 is null
set @stacksize1=0
if @dur is null
set @dur=0

insert into itemler 
(dwid,stacksize,durability,struserid,sira,itembasicname
,extname) 
values(@dwid,@stacksize1,@dur,@StrUserID,(@i-1) 
/ 8,@extname,@name )

set @i=@i+8

end
end