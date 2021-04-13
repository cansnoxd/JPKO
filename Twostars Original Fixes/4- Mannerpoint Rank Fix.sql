--Fixes Clan Grades for 1.298
--Can_SnoxD
--
--
USE KN_online
--
GO

/****** Object:  Table [dbo].[USER_MANNERPOINT_RANK]    Script Date: 11.4.2020 00:04:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[USER_MANNERPOINT_RANK](
	[nRank] [smallint] NOT NULL,
	[nElmoUP] [smallint] NOT NULL,
	[strElmoUserID] [char](21) NULL,
	[nElmoMannerPoint] [int] NULL,
	[nKarusUP] [smallint] NOT NULL,
	[strKarusUserID] [char](21) NULL,
	[nKarusMannerPoint] [int] NULL,
	[UpdateDate] [smalldatetime] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


