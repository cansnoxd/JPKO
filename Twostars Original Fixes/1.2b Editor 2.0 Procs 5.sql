--Editor 2.0 Procedures Part 5 1.298
--Can_SnoxD
--
--
USE KN_online
--
GO
CREATE procedure [dbo].[ITEMLERI_BUL_BANKA]
@StrUserID varchar(30)
AS
DECLARE
@length int, -- stritem uzunluğu
@i int, -- item'in stritem deki yeri
@dwid int, 
@dur int,
 @Kocuce int,
@StackSize1 int,
@Sira int,
@Row int,
@extname varchar(50),
@item varchar(30)

select @item=WareHouseData from warehouse where strAccountID=@StrUserID
if @item is null
	update WAREHOUSE set WarehouseData = null where strAccountID=@StrUserID

delete from warehouse_itemler where struserid=@StrUserID

    set @i = 14*0+1
    set @length=1601

select @row=count(*) from warehouse where straccountid=@StrUserID

if @row>0 
  begin

WHILE @i < @length
Begin

--Buraya İşemek Yasaktır
Select @dwid=cast(cast(substring(cast(substring(WarehouseData, @i,4) as varbinary(4)), 4, 1)+substring(cast(substring(WarehouseData, @i,4) as varbinary(4)), 3, 1)+substring(cast(substring(WarehouseData, @i,4) as varbinary(4)), 2, 
1)+substring(cast(substring(WarehouseData, @i,4) as varbinary(4)), 1, 1) as varbinary(4)) as varbinary(4)),
@dur = cast(cast(cast( substring(WarehouseData, @i+5, 1) as varbinary(1))+cast(substring(WarehouseData, @i+4, 1) as varbinary(1)) as varbinary(2)) as smallint),
@StackSize1 = cast(cast(cast( substring(WarehouseData, @i+7, 1) as varbinary(1))+cast(substring(WarehouseData, @i+6, 1) as varbinary(1)) as varbinary(2)) as smallint),
        @StrUserID = straccountid
        From warehouse
        Where straccountid = @StrUserID

if @dwid=0 
begin
set @extname='~~~~~~ item yok ~~~~~~'
end
else
begin
set @extname='Bulunamadı'

select @extname=strname from item where num=@dwid
end

insert into warehouse_itemler values(@dwid,@stacksize1,@dur,@StrUserID,(@i-1) / 8,@extname )

set @i=@i+8

end

select * from warehouse_itemler where struserid=@StrUserID order by sira

end


