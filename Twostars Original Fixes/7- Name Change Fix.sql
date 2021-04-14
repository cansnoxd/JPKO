--Fixes name change user editors uses for 1.298
--Can_SnoxD
--
--
USE KN_online
--
GO
/****** Object:  StoredProcedure [dbo].[ACCOUNT_CHAR_NAME_CHANGE]    Script Date: 07/02/2008 21:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* if exist use ALTER PROC*/
CREATE procedure [dbo].[ACCOUNT_CHAR_NAME_CHANGE]
(@strOldUserId varchar(30),@StrNewUserId varchar(30))
AS 
DECLARE @strCheckOldUserID varchar(30),@strCheckNewUserID varchar(30)
BEGIN TRAN
SELECT @strCheckOldUserID = Count(strUserId) FROM USERDATA WHERE strUserId = @strOldUserId
IF @strCheckOldUserID = 0
BEGIN
PRINT 'There is no [' + @strOldUserId + '] character in your database !'
END
ELSE
BEGIN
SELECT @strCheckNewUserID = Count(strUserId) FROM USERDATA WHERE strUserId = @StrNewUserId
IF @strCheckNewUserID = 0
BEGIN
-- Changes All Information on Account Tables
UPDATE ACCOUNT_CHAR set strCharID1 = @StrNewUserId WHERE strCharID1 = @strOldUserId
UPDATE ACCOUNT_CHAR set strCharID2 = @StrNewUserId WHERE strCharID2 = @strOldUserId
UPDATE ACCOUNT_CHAR set strCharID3 = @StrNewUserId WHERE strCharID3 = @strOldUserId
UPDATE USERDATA SET strUserId = @StrNewUserId WHERE strUserId = @strOldUserId
-- Changes ALL Information a User in Knights Tables
UPDATE KNIGHTS_USER SET strUserId = @StrNewUserId WHERE strUserId = @strOldUserId
UPDATE KNIGHTS SET Chief = @StrNewUserId WHERE Chief = @strOldUserId
UPDATE KNIGHTS SET ViceChief_1 = @StrNewUserId WHERE ViceChief_1 = @strOldUserId
UPDATE KNIGHTS SET ViceChief_2 = @StrNewUserId WHERE ViceChief_2 = @strOldUserId
UPDATE KNIGHTS SET ViceChief_3 = @StrNewUserId WHERE ViceChief_3 = @strOldUserId
-- Changes ALL Information a User is King Tables
UPDATE KING_SYSTEM SET strKingName = @StrNewUserId WHERE strKingName = @strOldUserId
UPDATE KING_ELECTION_LIST SET strName = @StrNewUserId WHERE strName = @strOldUserId
-- Change User Friend List Information Table
UPDATE FRIEND_LIST SET strUserID = @StrNewUserId where strUserID = @strCheckOldUserID
-- Changes User Rental Item Tables
UPDATE RENTAL_ITEM SET strLenderCharID = @StrNewUserId WHERE strLenderCharID = @strCheckOldUserID
UPDATE RENTAL_ITEM SET strBorrowerCharID = @StrNewUserId WHERE strBorrowerCharID = @strCheckOldUserID
UPDATE RENTAL_ITEM_LIST SET strBorrowerCharID = @StrNewUserId WHERE strBorrowerCharID = @strCheckOldUserID
-- Change CurrentUser Table
UPDATE CURRENTUSER SET strCharID = @StrNewUserId WHERE strCharID = @strCheckOldUserID
-- Name Change is Sucessfully Done
PRINT @strOldUserId + ' ==> Character changed to' + @strNewUserId + ' ==> succesfully.'
END
ELSE
BEGIN
PRINT @StrNewUserId + ' There is already a character in database like this !'
END
END
COMMIT TRAN