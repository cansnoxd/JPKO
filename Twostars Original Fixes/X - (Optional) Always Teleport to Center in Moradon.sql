--This is an optional script you dont need to use this , basicly what it does it center your respawn point to moradon everytime you relog for 1.298
--Made originaly by korean dudes below
--
--
USE KN_online
--
GO
/****** Object:  StoredProcedure [dbo].[LOAD_USER_DATA]    Script Date: 19.5.2020 04:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Object:  Stored Procedure dbo.LOAD_USER_DATA    Script Date: 6/6/2006 6:03:33 PM ******/

/****** 개체: 저장 프로시저 dbo.LOAD_USER_DATA    스크립트 날짜: 2002-11-14 오전 11:18:04 ******/
-- modifed by Sungyong 2003.04.09
-- 2004.04.22 월간기여도(LoyaltyMonthly) 추가 arycoat

ALTER PROCEDURE [dbo].[LOAD_USER_DATA]
    @AccountID  char(21) ,
    @id             char(21),
    @nRet        smallint OUTPUT
AS
BEGIN
    DECLARE @PosX int, @PosZ int, @PosY int, @Zone tinyint
    SELECT @Zone = Zone, @PosX = px, @PosZ = pz, @PosY = py FROM USERDATA WHERE strUserId = @id

    -- If the zone is Moradon...
    IF @Zone = 21
    BEGIN
        -- Use old Moradon co-ordinates ( * 100)
        -- I'm not using the new map but you can change the co-ordinates here.
        SET @PosX = 31100
        SET @PosY = 0 -- If we're higher or lower (depth-wise), we set this. Otherwise, it remains 0.
        SET @PosZ = 35100
    END

    SELECT Nation, Race, Class, HairColor, Rank, Title, [Level], [Exp], Loyalty, Face, City, Knights, Fame, Hp, Mp, Sp, Strong, Sta, Dex, Intel, Cha, Authority, Points, Gold, [Zone], Bind, @PosX, @PosZ, @PosY, dwTime, strSkill, strItem,strSerial, sQuestCount, strQuest, MannerPoint, LoyaltyMonthly FROM    USERDATA WHERE strUserId = @id
    SET @nRet = @@RowCount
END
