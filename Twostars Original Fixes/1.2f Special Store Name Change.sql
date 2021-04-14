--Special store [Selith] name change +0 1.298
--Credits goes to Kageyoshi
--
--
USE KN_online
--
/* Selith - Change ID - fixed with store procedure */
--
GO
CREATE PROCEDURE dbo.CHANGE_NEW_ID
@byType char(21),
@AccountID char(21),
@charid varchar(32),
@newid varchar(32),
@nRet smallint output
as
DECLARE @count int, @x int, @chr int
BEGIN TRAN
SELECT @count = COUNT(*) FROM USERDATA WHERE strUserId = @newid
IF @count >= 1
BEGIN
SET @nRet = 4 
RETURN
END
ELSE
BEGIN
IF @newid LIKE '%GM%' OR @newid LIKE '%fuck%' or @newid LIKE '%fuk%' or @newid LIKE '%shit%' 
BEGIN
SET @nRet = 3
RETURN
END
SET @x = 1
WHILE @x <= LEN(@newid)
BEGIN
SET @chr = ASCII(SUBSTRING(@newid, @x, 1))
IF @chr < 48 OR (@chr > 59 AND @chr < 65) OR @chr > 122
BEGIN
SET @nRet = 3
RETURN
END
SET @x = @x + 1
END
--
update userdata set strUserID = @newid where strUserID = @charid
update friend_list set strUserID = @newid where strUserID = @charid
update king_ballot_box set strCharID = @newid where strCharID = @charid
update king_candidacy_notice_board set strUserID = @newid where strUserID = @charid
update king_election_list set strName = @newid where strName = @charid
update king_system set strKingName = @newid where strKingName = @charid
update rental_item set strLenderCharID = @newid where strLenderCharID = @charid
update rental_item set strBorrowerCharID = @newid where strBorrowerCharID = @charid
update rental_item_list set strBorrowerCharID = @newid where strBorrowerCharID = @charid
update account_char set strCharID1 = @newid where strCharID1 = @charid
update account_char set strCharID2 = @newid where strCharID2 = @charid
update account_char set strCharID3 = @newid where strCharID3 = @charid
END
COMMIT TRAN