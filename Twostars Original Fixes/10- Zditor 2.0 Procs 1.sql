--Editor 2.0 Procedures Part 1 1.298
--Can_SnoxD
--
--
USE KN_online
--
GO
CREATE PROCEDURE [dbo].[INSERTITEM]
@StrUserID varchar(30),
@NEWNum int,
@StackSize int
AS
DECLARE
@length int,
@row int,
@i int,
@Num int,
@pos int,
@dur int,
@dur1 int,
@ext int,
@StackSize1 int,
@strName varchar(30),
@strExtName varchar(30),
@CNum varbinary(4),
@cdur varchar(2),
@cstack varchar(2),
@stritemname varchar(21),
@itemexist int
BEGIN TRAN
select @itemexist = count(*) from item where num = @newnum
if (@itemexist < 1)
begin
select @StrUserID, 0, 0, 0, 'Invalid Item ID', 'Item Doesnt Exist'
ROLLBACK TRAN
RETURN
end
If (@StackSize > 9999) or (@StackSize < 1)
begin
select @StrUserID, 0, 0, 0, 'Invalid StackSize', 'Stack size 1 > 9999'
ROLLBACK TRAN
RETURN
end
Begin
set @i = 1
set @length=1601
Select @row = count(*) From warehouse Where straccountid like @StrUserID
If @row = 0 or @row > 1
Begin
Select @StrUserID, 0, 0, 0, 'Invalid ID', 'Please check the name against the datasource'
ROLLBACK TRAN
RETURN
End
Select @row = count(*) From warehouse Where (straccountid like @StrUserID) and (warehousedata is NULL)
If @row > 0
Begin
Select @StrUserID, 0, 0, 0, 'No Data', 'StrItem is NULL'
ROLLBACK TRAN
RETURN
End
End
select @stritemname = strname from item where num = @newnum
WHILE @i < @length
Begin
Select @Num=cast(cast(substring(cast(substring(warehousedata, @i,4) as varbinary(4)), 4, 1)+substring(cast(substring(warehousedata, @i,4) as varbinary(4)), 3, 1)+substring(cast(substring(warehousedata, @i,4) as varbinary(4)), 2, 1)+substring(cast(substring(warehousedata, @i,4) as varbinary(4)), 1, 1) as varbinary(4)) as int),
@dur = cast(cast(cast( substring(warehousedata, @i+5, 1) as varbinary(1))+cast(substring(warehousedata, @i+4, 1) as varbinary(1)) as varbinary(2)) as smallint),
@StackSize1 = cast(cast(cast( substring(warehousedata, @i+7, 1) as varbinary(1))+cast(substring(warehousedata, @i+6, 1) as varbinary(1)) as varbinary(2)) as smallint)
From warehouse
Where straccountid = @StrUserID
If @Num = 0
begin
If @dur = 0
Begin
If @StackSize1 = 0
Begin
select @dur = Duration from ITEM where Num = @NEWNum
If @StackSize > 1
Set @dur = 1
Set @CNum = Substring(cast(@NEWNum as varbinary(4)), 4, 1) + Substring(cast(@NEWNum as varbinary(4)), 3, 1) + Substring(cast(@NEWNum as varbinary(4)), 2, 1) + Substring(cast(@NEWNum as varbinary(4)), 1, 1)
Set @Cdur = cast(Substring(cast(@dur as varbinary(2)), 2, 1)+Substring(cast(@dur as varbinary(2)), 1, 1) as varchar(2))
Set @Cstack = cast(Substring(cast(@StackSize as varbinary(2)), 2, 1)+Substring(cast(@StackSize as varbinary(2)), 1, 1) as varchar(2))
Begin
--select cast(warehousedata as varbinary(1600)) from warehouse where strAccountID = @strUserID
--select cast( substring(WareHouseData, 1, @i-1) + cast(cast(@CNum as varchar(4)) + @Cdur + @Cstack as varchar(8)) + substring(WareHouseData, @i+8, 1601-@i) as binary(1600)) from warehouse where strAccountID = @strUserID
update warehouse set warehousedata = cast( substring(warehousedata, 1, @i-1) + cast(cast(@CNum as varchar(4)) + @Cdur + @Cstack as nvarchar(8)) + substring(warehousedata, @i+8, 1601-@i) as binary(1600)) where straccountid = @strUserID
COMMIT TRAN
RETURN
End
End
End
End
set @i = @i + 8
End
GO
