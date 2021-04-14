--Nation Transfer Code for Editors or Manual Use 1.298
--To use manualy EXEC ACCOUNT_NATION_TRANSFER 'ACCOUNT_NAME_HERE'
--Can_SnoxD
--
--
USE KN_online
--
GO
/****** Object:  StoredProcedure [dbo].[ACCOUNT_NATION_TRANSFER]    Script Date: 14.4.2021 03:26:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Use ALTER PROCEDURE if exist*/
CREATE PROCEDURE [dbo].[ACCOUNT_NATION_TRANSFER]
@AccountID char(21)
AS
--
DECLARE @IsValidAccountID tinyint
DECLARE @CurrentNation tinyint
DECLARE @InGameStatus tinyint
DECLARE @NewNation tinyint
DECLARE @Knights smallint
DECLARE @CharNum tinyint
DECLARE @CharID char(21)
DECLARE @Class tinyint
DECLARE @Race tinyint
DECLARE @Fame tinyint
--
IF @AccountID = ''
BEGIN

	DECLARE @ID int
	DECLARE @ANTAccountID char(21)

	DECLARE ANT_CURSOR CURSOR FOR
	SELECT ID,AccountID FROM ACCOUNT_NATION_TRANSFERS_QUEUE WHERE Process = 0

	OPEN ANT_CURSOR

	FETCH NEXT FROM ANT_CURSOR INTO @ID,@ANTAccountID
	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT @CurrentNation = bNation FROM ACCOUNT_CHAR WHERE strAccountID = @ANTAccountID

		IF @CurrentNation = 1
			SET @NewNation = 2
		ELSE
			SET @NewNation = 1

                          SET @CharID = NULL
		SET @Fame = 0
		SET @Knights = 0
		SET @Race = 0
		SET @Class = 0

		SELECT @CharID = strCharID1 FROM ACCOUNT_CHAR WHERE strAccountID = @ANTAccountID AND strCharID1 IS NOT NULL

		IF @CharID IS NOT NULL
		BEGIN
			SELECT @Race = Race,@Class = Class,@Knights = Knights,@Fame = Fame FROM USERDATA WHERE strUserId = @CharID

			IF @Race = 1
				SET @Race = 12
			ELSE IF @Race = 2
				SET @Race = 12
			ELSE IF @Race = 3
				SET @Race = 12
			ELSE IF @Race = 4
				SET @Race = 13
			ELSE IF @Race = 11
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 201
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 205
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 206
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 201
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 205
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 206
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 202
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 207
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 208
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 202
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 207
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 208
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 203
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 209
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 210
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 203
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 209
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 210
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 204
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 211
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 212
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 204
				SET @Race = 4
			ELSE IF @Race = 13 AND @Class = 211
				SET @Race = 4
			ELSE IF @Race = 13 AND @Class = 212
				SET @Race = 4

			IF @NewNation = 1
				SET @Class = @Class - 100
			ELSE
				SET @Class = @Class + 100

			UPDATE USERDATA SET Nation = @NewNation,Race = @Race,Class = @Class,Knights = 0,Fame = 0, Rank = 0, Title = 0 FROM USERDATA WHERE strUserId = @CharID
				
			IF @Knights <> 0 AND @Fame = 0
			BEGIN
				DELETE FROM KNIGHTS_USER WHERE strUserID = @CharID
				UPDATE KNIGHTS SET ViceChief_1 = NULL WHERE ViceChief_1 = @CharID AND ViceChief_1 IS NOT NULL
				UPDATE KNIGHTS SET ViceChief_2 = NULL WHERE ViceChief_2 = @CharID AND ViceChief_2 IS NOT NULL
				UPDATE KNIGHTS SET ViceChief_3 = NULL WHERE ViceChief_3 = @CharID AND ViceChief_3 IS NOT NULL
			END		
			ELSE IF @Knights <> 0 AND @Fame = 1
			BEGIN
				EXEC DELETE_KNIGHTS 0,@Knights
			END

			UPDATE KING_SYSTEM SET strKingName = NULL WHERE strKingName = @CharID AND strKingName IS NOT NULL AND byNation = @CurrentNation
		END
		
                          SET @CharID = NULL
		SET @Fame = 0
		SET @Knights = 0
		SET @Race = 0
		SET @Class = 0
		
		SELECT @CharID = strCharID2 FROM ACCOUNT_CHAR WHERE strAccountID = @ANTAccountID AND strCharID2 IS NOT NULL

		IF @CharID IS NOT NULL
		BEGIN
			SELECT @Race = Race,@Class = Class,@Knights = Knights,@Fame = Fame FROM USERDATA WHERE strUserId = @CharID

			IF @Race = 1
				SET @Race = 12
			ELSE IF @Race = 2
				SET @Race = 12
			ELSE IF @Race = 3
				SET @Race = 12
			ELSE IF @Race = 4
				SET @Race = 13
			ELSE IF @Race = 11
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 201
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 205
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 206
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 201
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 205
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 206
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 202
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 207
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 208
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 202
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 207
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 208
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 203
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 209
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 210
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 203
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 209
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 210
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 204
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 211
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 212
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 204
				SET @Race = 4
			ELSE IF @Race = 13 AND @Class = 211
				SET @Race = 4
			ELSE IF @Race = 13 AND @Class = 212
				SET @Race = 4

			IF @NewNation = 1
				SET @Class = @Class - 100
			ELSE
				SET @Class = @Class + 100

			UPDATE USERDATA SET Nation = @NewNation,Race = @Race,Class = @Class,Knights = 0,Fame = 0, Rank = 0, Title = 0 FROM USERDATA WHERE strUserId = @CharID
				
			IF @Knights <> 0 AND @Fame = 0
			BEGIN
				DELETE FROM KNIGHTS_USER WHERE strUserID = @CharID
				UPDATE KNIGHTS SET ViceChief_1 = NULL WHERE ViceChief_1 = @CharID AND ViceChief_1 IS NOT NULL
				UPDATE KNIGHTS SET ViceChief_2 = NULL WHERE ViceChief_2 = @CharID AND ViceChief_2 IS NOT NULL
				UPDATE KNIGHTS SET ViceChief_3 = NULL WHERE ViceChief_3 = @CharID AND ViceChief_3 IS NOT NULL
			END		
			ELSE IF @Knights <> 0 AND @Fame = 1
			BEGIN
				EXEC DELETE_KNIGHTS 0,@Knights
			END

			UPDATE KING_SYSTEM SET strKingName = NULL WHERE strKingName = @CharID AND strKingName IS NOT NULL AND byNation = @CurrentNation
		END

                          SET @CharID = NULL
		SET @Fame = 0
		SET @Knights = 0
		SET @Race = 0
		SET @Class = 0
		
		SELECT @CharID = strCharID3 FROM ACCOUNT_CHAR WHERE strAccountID = @ANTAccountID AND strCharID3 IS NOT NULL

		IF @CharID IS NOT NULL
		BEGIN
			SELECT @Race = Race,@Class = Class,@Knights = Knights,@Fame = Fame FROM USERDATA WHERE strUserId = @CharID

			IF @Race = 1
				SET @Race = 12
			ELSE IF @Race = 2
				SET @Race = 12
			ELSE IF @Race = 3
				SET @Race = 12
			ELSE IF @Race = 4
				SET @Race = 13
			ELSE IF @Race = 11
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 201
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 205
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 206
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 201
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 205
				SET @Race = 1
			ELSE IF @Race = 13 AND @Class = 206
				SET @Race = 1
			ELSE IF @Race = 12 AND @Class = 202
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 207
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 208
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 202
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 207
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 208
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 203
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 209
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 210
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 203
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 209
				SET @Race = 3
			ELSE IF @Race = 13 AND @Class = 210
				SET @Race = 3
			ELSE IF @Race = 12 AND @Class = 204
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 211
				SET @Race = 2
			ELSE IF @Race = 12 AND @Class = 212
				SET @Race = 2
			ELSE IF @Race = 13 AND @Class = 204
				SET @Race = 4
			ELSE IF @Race = 13 AND @Class = 211
				SET @Race = 4
			ELSE IF @Race = 13 AND @Class = 212
				SET @Race = 4

			IF @NewNation = 1
				SET @Class = @Class - 100
			ELSE
				SET @Class = @Class + 100

			UPDATE USERDATA SET Nation = @NewNation,Race = @Race,Class = @Class,Knights = 0,Fame = 0, Rank = 0, Title = 0 FROM USERDATA WHERE strUserId = @CharID
				
			IF @Knights <> 0 AND @Fame = 0
			BEGIN
				DELETE FROM KNIGHTS_USER WHERE strUserID = @CharID
				UPDATE KNIGHTS SET ViceChief_1 = NULL WHERE ViceChief_1 = @CharID AND ViceChief_1 IS NOT NULL
				UPDATE KNIGHTS SET ViceChief_2 = NULL WHERE ViceChief_2 = @CharID AND ViceChief_2 IS NOT NULL
				UPDATE KNIGHTS SET ViceChief_3 = NULL WHERE ViceChief_3 = @CharID AND ViceChief_3 IS NOT NULL
			END		
			ELSE IF @Knights <> 0 AND @Fame = 1
			BEGIN
				EXEC DELETE_KNIGHTS 0,@Knights
			END

			UPDATE KING_SYSTEM SET strKingName = NULL WHERE strKingName = @CharID AND strKingName IS NOT NULL AND byNation = @CurrentNation
		END

		UPDATE ACCOUNT_CHAR SET bNation = @NewNation WHERE strAccountID = @ANTAccountID

		IF @NewNation = 1
			UPDATE ACCOUNT_NATION_TRANSFERS_QUEUE SET Process = 1,Description = 'El Morad to Karus race change succesfully done !',UpdatedTime = GETDATE() WHERE ID = @ID AND AccountID = @ANTAccountID
		ELSE
			UPDATE ACCOUNT_NATION_TRANSFERS_QUEUE SET Process = 1,Description = 'Karus to El Morad race change succesfully done !',UpdatedTime = GETDATE() WHERE ID = @ID AND AccountID = @ANTAccountID
		

	FETCH NEXT FROM ANT_CURSOR INTO @ID,@ANTAccountID
	END

CLOSE ANT_CURSOR
DEALLOCATE ANT_CURSOR

END
ELSE
BEGIN

	SELECT @IsValidAccountID = COUNT(strAccountID) FROM TB_USER WHERE strAccountID = @AccountID

	IF @IsValidAccountID = 0
	BEGIN
		PRINT '# Race Transfer Results ;'
		PRINT '#'
		PRINT '# ' + RTRIM(LTRIM(@AccountID)) + ' there are no account like that , your transfer failed !'
		PRINT '#'
	END
	ELSE
	BEGIN

		SELECT @InGameStatus = COUNT(*) FROM CURRENTUSER WHERE strAccountID = @AccountID

		SELECT @CharNum = bCharNum FROM ACCOUNT_CHAR WHERE strAccountID = @AccountID
	
		IF @InGameStatus = 0 AND @CharNum <> 0
		BEGIN

			SELECT @CurrentNation = bNation FROM ACCOUNT_CHAR WHERE strAccountID = @AccountID

			IF @CurrentNation = 1
				SET @NewNation = 2
			ELSE
				SET @NewNation = 1

                                       SET @CharID = NULL
		             SET @Fame = 0
		             SET @Knights = 0
		             SET @Race = 0
		             SET @Class = 0

			SELECT @CharID = strCharID1 FROM ACCOUNT_CHAR WHERE strAccountID = @AccountID AND strCharID1 IS NOT NULL

			IF @CharID IS NOT NULL
			BEGIN
				SELECT @Race = Race,@Class = Class,@Knights = Knights,@Fame = Fame FROM USERDATA WHERE strUserId = @CharID

				IF @Race = 1
					SET @Race = 12
				ELSE IF @Race = 2
					SET @Race = 12
				ELSE IF @Race = 3
					SET @Race = 12
				ELSE IF @Race = 4
					SET @Race = 13
				ELSE IF @Race = 11
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 201
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 205
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 206
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 201
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 205
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 206
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 202
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 207
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 208
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 202
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 207
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 208
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 203
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 209
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 210
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 203
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 209
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 210
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 204
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 211
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 212
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 204
					SET @Race = 4
				ELSE IF @Race = 13 AND @Class = 211
					SET @Race = 4
				ELSE IF @Race = 13 AND @Class = 212
					SET @Race = 4


				IF @NewNation = 1
					SET @Class = @Class - 100
				ELSE
					SET @Class = @Class + 100

				UPDATE USERDATA SET Nation = @NewNation,Race = @Race,Class = @Class,Knights = 0,Fame = 0, Rank = 0, Title = 0 FROM USERDATA WHERE strUserId = @CharID

				IF @Knights <> 0 AND @Fame = 0
				BEGIN
					DELETE FROM KNIGHTS_USER WHERE strUserID = @CharID
					UPDATE KNIGHTS SET ViceChief_1 = NULL WHERE ViceChief_1 = @CharID AND ViceChief_1 IS NOT NULL
					UPDATE KNIGHTS SET ViceChief_2 = NULL WHERE ViceChief_2 = @CharID AND ViceChief_2 IS NOT NULL
					UPDATE KNIGHTS SET ViceChief_3 = NULL WHERE ViceChief_3 = @CharID AND ViceChief_3 IS NOT NULL
				END		
				ELSE IF @Knights <> 0 AND @Fame = 1
				BEGIN
					EXEC DELETE_KNIGHTS 0,@Knights
				END

				UPDATE KING_SYSTEM SET strKingName = NULL WHERE strKingName = @CharID AND strKingName IS NOT NULL AND byNation = @CurrentNation
			END
			
                                       SET @CharID = NULL
		             SET @Fame = 0
		             SET @Knights = 0
		             SET @Race = 0
		             SET @Class = 0

			SELECT @CharID = strCharID2 FROM ACCOUNT_CHAR WHERE strAccountID = @AccountID AND strCharID2 IS NOT NULL

			IF @CharID IS NOT NULL
			BEGIN
				SELECT @Race = Race,@Class = Class,@Knights = Knights,@Fame = Fame FROM USERDATA WHERE strUserId = @CharID

				IF @Race = 1
					SET @Race = 12
				ELSE IF @Race = 2
					SET @Race = 12
				ELSE IF @Race = 3
					SET @Race = 12
				ELSE IF @Race = 4
					SET @Race = 13
				ELSE IF @Race = 11
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 201
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 205
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 206
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 201
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 205
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 206
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 202
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 207
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 208
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 202
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 207
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 208
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 203
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 209
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 210
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 203
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 209
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 210
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 204
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 211
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 212
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 204
					SET @Race = 4
				ELSE IF @Race = 13 AND @Class = 211
					SET @Race = 4
				ELSE IF @Race = 13 AND @Class = 212
					SET @Race = 4


				IF @NewNation = 1
					SET @Class = @Class - 100
				ELSE
					SET @Class = @Class + 100

				UPDATE USERDATA SET Nation = @NewNation,Race = @Race,Class = @Class,Knights = 0,Fame = 0, Rank = 0, Title = 0 FROM USERDATA WHERE strUserId = @CharID

				IF @Knights <> 0 AND @Fame = 0
				BEGIN
					DELETE FROM KNIGHTS_USER WHERE strUserID = @CharID
					UPDATE KNIGHTS SET ViceChief_1 = NULL WHERE ViceChief_1 = @CharID AND ViceChief_1 IS NOT NULL
					UPDATE KNIGHTS SET ViceChief_2 = NULL WHERE ViceChief_2 = @CharID AND ViceChief_2 IS NOT NULL
					UPDATE KNIGHTS SET ViceChief_3 = NULL WHERE ViceChief_3 = @CharID AND ViceChief_3 IS NOT NULL
				END		
				ELSE IF @Knights <> 0 AND @Fame = 1
				BEGIN
					EXEC DELETE_KNIGHTS 0,@Knights
				END

				UPDATE KING_SYSTEM SET strKingName = NULL WHERE strKingName = @CharID AND strKingName IS NOT NULL AND byNation = @CurrentNation
			END

                                       SET @CharID = NULL
		             SET @Fame = 0
		             SET @Knights = 0
		             SET @Race = 0
		             SET @Class = 0
			
			SELECT @CharID = strCharID3 FROM ACCOUNT_CHAR WHERE strAccountID = @AccountID AND strCharID3 IS NOT NULL

			IF @CharID IS NOT NULL
			BEGIN
				SELECT @Race = Race,@Class = Class,@Knights = Knights,@Fame = Fame FROM USERDATA WHERE strUserId = @CharID

				IF @Race = 1
					SET @Race = 12
				ELSE IF @Race = 2
					SET @Race = 12
				ELSE IF @Race = 3
					SET @Race = 12
				ELSE IF @Race = 4
					SET @Race = 13
				ELSE IF @Race = 11
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 201
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 205
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 206
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 201
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 205
					SET @Race = 1
				ELSE IF @Race = 13 AND @Class = 206
					SET @Race = 1
				ELSE IF @Race = 12 AND @Class = 202
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 207
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 208
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 202
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 207
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 208
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 203
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 209
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 210
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 203
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 209
					SET @Race = 3
				ELSE IF @Race = 13 AND @Class = 210
					SET @Race = 3
				ELSE IF @Race = 12 AND @Class = 204
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 211
					SET @Race = 2
				ELSE IF @Race = 12 AND @Class = 212
					SET @Race = 2
				ELSE IF @Race = 13 AND @Class = 204
					SET @Race = 4
				ELSE IF @Race = 13 AND @Class = 211
					SET @Race = 4
				ELSE IF @Race = 13 AND @Class = 212
					SET @Race = 4


				IF @NewNation = 1
					SET @Class = @Class - 100
				ELSE
					SET @Class = @Class + 100

				UPDATE USERDATA SET Nation = @NewNation,Race = @Race,Class = @Class,Knights = 0,Fame = 0, Rank = 0, Title = 0 FROM USERDATA WHERE strUserId = @CharID

				IF @Knights <> 0 AND @Fame = 0
				BEGIN
					DELETE FROM KNIGHTS_USER WHERE strUserID = @CharID
					UPDATE KNIGHTS SET ViceChief_1 = NULL WHERE ViceChief_1 = @CharID AND ViceChief_1 IS NOT NULL
					UPDATE KNIGHTS SET ViceChief_2 = NULL WHERE ViceChief_2 = @CharID AND ViceChief_2 IS NOT NULL
					UPDATE KNIGHTS SET ViceChief_3 = NULL WHERE ViceChief_3 = @CharID AND ViceChief_3 IS NOT NULL
				END		
				ELSE IF @Knights <> 0 AND @Fame = 1
				BEGIN
					EXEC DELETE_KNIGHTS 0,@Knights
				END

				UPDATE KING_SYSTEM SET strKingName = NULL WHERE strKingName = @CharID AND strKingName IS NOT NULL AND byNation = @CurrentNation
			END

			UPDATE ACCOUNT_CHAR SET bNation = @NewNation WHERE strAccountID = @AccountID

			IF @NewNation = 1
			BEGIN
				INSERT INTO ACCOUNT_NATION_TRANSFERS_QUEUE (AccountID,Process,Description,UpdatedTime) VALUES (@AccountID,1,'El Morad to Karus Transfer is done !',GETDATE())
				PRINT '# Race Transfer Results ;'
				PRINT '#'
				PRINT '# ' + RTRIM(LTRIM(@AccountID)) + 's El Morad to Karus Transfer is done !'
				PRINT '#'
			END
			ELSE
			BEGIN
				INSERT INTO ACCOUNT_NATION_TRANSFERS_QUEUE (AccountID,Process,Description,UpdatedTime) VALUES (@AccountID,1,'Karus to El Morad Transfer is done !',GETDATE())
				PRINT '# Race Transfer Results ;'
				PRINT '#'
				PRINT '# ' + RTRIM(LTRIM(@AccountID)) + 's Karus to El Morad Transfer is done !'
				PRINT '#'
			END
		
		
		END
		ELSE IF @InGameStatus <> 0 AND @CharNum <> 0
		BEGIN
			INSERT INTO ACCOUNT_NATION_TRANSFERS_QUEUE (AccountID,Process,Description,UpdatedTime) VALUES (@AccountID,0,'is not done yet',GETDATE())
			END
END
END