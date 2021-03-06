--Editor 2.0 Procedures Part 6 1.298
--Can_SnoxD
--
--
USE KN_online
--

GO

/****** Object:  StoredProcedure [dbo].[itemleri_encode]    Script Date: 01/17/2013 00:15:45 ******/

SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER OFF

GO



Create procedure [dbo].[itemleri_encode]

@StrUserID varchar(30)

AS

DECLARE

@length int, -- stritem uzunluğu

@row int, -- yerine göre deişior.

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

set @length = 601



select @row=count( * ) from userdata where struserid=@StrUserID



if @row>0

begin





Select @dwid=dwid,

@dur = durability,

@StackSize1 = stacksize,

@StrUserID = strUserID

From itemler

Where strUserID = @StrUserID and sira=@sira



Set @Cdwid = Substring(cast(@dwid as varbinary(4)), 4, 1) + Substring(cast(@dwid as varbinary(4)), 3, 1) +

Substring(cast(@dwid as varbinary(4)), 2, 1) + Substring(cast(@dwid as varbinary(4)), 1, 1)

Set @Cdur = cast(Substring(cast(@dur as varbinary(2)), 2, 1)+Substring(cast(@dur as varbinary(2)), 1, 1) as

varchar(2))

Set @Cstack = cast(Substring(cast(@StackSize1 as varbinary(2)), 2, 1)+Substring(cast(@StackSize1 as

varbinary(2)), 1, 1) as varchar(2))





update UserData set strItem = cast(cast(cast(@Cdwid as varchar(4)) + @Cdur + @Cstack as varchar(8)) as

binary(600)) where strUserID = @strUserID





set @i=@i+8

set @sira=@sira+1





WHILE @sira < 50

Begin



Select @dwid=dwid,

@dur = durability,

@StackSize1 = stacksize,

@StrUserID = strUserID

From itemler

Where strUserID = @StrUserID and sira=@sira



Set @Cdwid = Substring(cast(@dwid as varbinary(4)), 4, 1) + Substring(cast(@dwid as varbinary(4)), 3, 1) +

Substring(cast(@dwid as varbinary(4)), 2, 1) + Substring(cast(@dwid as varbinary(4)), 1, 1)

Set @Cdur = cast(Substring(cast(@dur as varbinary(2)), 2, 1)+Substring(cast(@dur as varbinary(2)), 1, 1) as

varchar(2))

Set @Cstack = cast(Substring(cast(@StackSize1 as varbinary(2)), 2, 1)+Substring(cast(@StackSize1 as

varbinary(2)), 1, 1) as varchar(2))





update UserData set strItem = cast( substring(strItem, 1, @i) + cast(cast(@Cdwid as varchar(4)) + @Cdur +

@Cstack as varchar(8)) + substring(strItem, @i+8, 601-@i) as binary(600)) where strUserID = @strUserID





set @i=@i+8

set @sira=@sira+1



end

end

delete from itemler