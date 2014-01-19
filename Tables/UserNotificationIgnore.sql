USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserNotificationIgnore]    Script Date: 01/08/2014 23:06:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserNotificationIgnore](
	[userId] [uniqueidentifier] NOT NULL,
	[supplierId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]

GO

