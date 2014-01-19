USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[Permission]    Script Date: 01/08/2014 22:58:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Permission](
	[userId] [uniqueidentifier] NOT NULL,
	[aggregationId] [int] NOT NULL,
	[objectId] [int] NOT NULL
) ON [PRIMARY]

GO

