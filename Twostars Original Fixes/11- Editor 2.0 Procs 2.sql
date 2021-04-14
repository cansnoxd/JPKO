--Editor 2.0 Procedures Part 2 1.298
--Can_SnoxD
--
--
USE KN_online
--
GO

/****** Object:  Table [dbo].[itemler]    Script Date: 11.4.2020 21:42:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[itemler](
	[dwid] [int] NULL,
	[stacksize] [smallint] NULL,
	[durability] [smallint] NULL,
	[strUserId] [varchar](50) NULL,
	[sira] [int] NULL,
	[itembasicname] [varchar](100) NULL,
	[extname] [varchar](100) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO