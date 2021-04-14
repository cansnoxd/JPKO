--Fixes Clan Grades for 1.298
--Can_SnoxD
--
--
USE KN_online
--
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_MANNERPOINT_RANK]    Script Date: 11.4.2020 16:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Stored Procedure dbo.UPDATE_MANNERPOINT_RANK    Script Date: 6/6/2006 6:03:32 PM ******/

--
-- 매너포인트 순위
-- 2004. 4. 30 arycoat
--
/* if exist use ALTER PROC*/
CREATE PROC [dbo].[UPDATE_MANNERPOINT_RANK]

AS


DECLARE @tUpdateDate SMALLDATETIME

SET @tUpdateDate =CONVERT(VARCHAR(15) , GETDATE(),102)
SET @tUpdateDate = DATEADD(HH,DATEPART(HH,dateadd(mi, 10, GETDATE())),@tUpdateDate)

create table [#KARUS_RANK]
(
	[nRank] [int] IDENTITY (1, 1) NOT NULL ,
	[strUserID] char(21) NOT NULL,
	[MannerPoint] int NOT NULL,
	[Loyalty] int NOT NULL,
	[nRankUP] int NOT NULL
) ON [PRIMARY]

create table [#ELMO_RANK]
(
	[nRank] [int] IDENTITY (1, 1) NOT NULL ,
	[strUserID] char(21) NOT NULL,
	[MannerPoint] int NOT NULL,
	[Loyalty] int NOT NULL,
	[nRankUP] int NOT NULL
) ON [PRIMARY]


INSERT #KARUS_RANK
	select top 100 strUserID, MannerPoint, Loyalty, 101
	from USERDATA
	where Nation = 1
	order by MannerPoint desc, Loyalty desc

INSERT #ELMO_RANK
	select top 100 strUserID, MannerPoint, Loyalty, 101
	from USERDATA
	where Nation = 2
	order by MannerPoint desc, Loyalty desc


UPDATE #KARUS_RANK
	Set nRankUP = R.nRank - #KARUS_RANK.nRank
	from USER_MANNERPOINT_RANK R
	where R.strKarusUserID = #KARUS_RANK.strUserID
	COLLATE TURKISH_CI_AS

UPDATE #ELMO_RANK
	Set nRankUP = R.nRank - #ELMO_RANK.nRank
	from USER_MANNERPOINT_RANK R
	where R.strElmoUserID = #ELMO_RANK.strUserID
	COLLATE TURKISH_CI_AS


INSERT USER_MANNERPOINT_RANK
	select E.nRank, E.nRankUP, E.strUserID, E.MannerPoint, K.nRankUP, K.strUserID, K.MannerPoint, @tUpdateDate
	from #ELMO_RANK E, #KARUS_RANK K, USER_MANNERPOINT_RANK R
	WHERE (E.nRank = K.nRank AND E.nRank = R.nRank and R.UpdateDate < @tUpdateDate)
	ORDER BY E.nRank
DELETE FROM USER_MANNERPOINT_RANK
WHERE UpdateDate < @tUpdateDate
