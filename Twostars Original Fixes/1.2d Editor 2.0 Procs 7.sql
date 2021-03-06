--Editor 2.0 Procedures Part 7 1.298
--Can_SnoxD
--
--
USE KN_online
--
GO
CREATE procedure [dbo].[itemleri_encode_banka]
@StrUserID varchar(30)
AS
DECLARE
@length int, -- stritem uzunluðu
@row int, -- yerine göre deiþior.
@i int, -- item'in stritem deki yeri
@dwid int, -- dwid
@pos int,
@dur int,
@dur1 int,
@ext int,
@StackSize1 int,
@strName varchar(30),
@strExtName varchar(30),
@Cdwid varbinary(4),
@cdur varchar(2),
@Source tinyint,
@NEWdwid int,
@StackSize int,
@cstack varchar(2),
@sira int

    set @sira=0
    set @i = 14*0
    set @length = 1601

select @row=count( * ) from warehouse where strAccountID=@StrUserID

if @row>0 
  begin


Select @dwid=dwid,
@dur = durability,
@StackSize1 = stacksize,
        @StrUserID = strUserID
        From warehouse_itemler
        Where strUserID = @StrUserID and sira=@sira

    Set @Cdwid = Substring(cast(@dwid as varbinary(4)), 4, 1) + Substring(cast(@dwid as varbinary(4)), 3, 1) + Substring(cast(@dwid as varbinary(4)), 2, 1) + Substring(cast(@dwid as varbinary(4)), 1, 1)
    Set @Cdur = cast(Substring(cast(@dur as varbinary(2)), 2, 1)+Substring(cast(@dur as varbinary(2)), 1, 1) as varchar(2))
    Set @Cstack = cast(Substring(cast(@StackSize1 as varbinary(2)), 2, 1)+Substring(cast(@StackSize1 as varbinary(2)), 1, 1) as varchar(2))


    update WareHouse set warehousedata = cast(cast(cast(@Cdwid as varchar(4)) + @Cdur + @Cstack as varchar(8))   as binary(400)) where strAccountID = @strUserID



set @i=@i+8
set @sira=@sira+1


WHILE @sira < 200
Begin

Select @dwid=dwid,
@dur = durability,
@StackSize1 = stacksize,
        @StrUserID = strUserID
        From warehouse_itemler
        Where strUserID = @StrUserID and sira=@sira

    Set @Cdwid = Substring(cast(@dwid as varbinary(4)), 4, 1) + Substring(cast(@dwid as varbinary(4)), 3, 1) + Substring(cast(@dwid as varbinary(4)), 2, 1) + Substring(cast(@dwid as varbinary(4)), 1, 1)
    Set @Cdur = cast(Substring(cast(@dur as varbinary(2)), 2, 1)+Substring(cast(@dur as varbinary(2)), 1, 1) as varchar(2))
    Set @Cstack = cast(Substring(cast(@StackSize1 as varbinary(2)), 2, 1)+Substring(cast(@StackSize1 as varbinary(2)), 1, 1) as varchar(2))


    update warehouse set warehousedata = cast( substring(warehousedata, 1, @i) + cast(cast(@Cdwid as varchar(4)) + @Cdur + @Cstack as varchar(8)) + substring(warehousedata, @i+8, 1601-@i) as binary(1600)) where strAccountID = @strUserID


set @i=@i+8
set @sira=@sira+1

end
end
delete from warehouse_itemler
