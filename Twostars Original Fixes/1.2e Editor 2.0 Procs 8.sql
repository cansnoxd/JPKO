--Editor 2.0 Procedures Part 8 1.298
--Can_SnoxD
--
--
USE KN_online
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[warehouse_itemler]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[warehouse_itemler]
GO

CREATE TABLE [dbo].[WAREHOUSE_ITEMLER] (
	[dwid] [int] NOT NULL ,
	[stacksize] [smallint] NULL ,
	[durability] [smallint] NULL ,
	[strUserId] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[sira] [int] NULL ,
	[itembasicname] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO