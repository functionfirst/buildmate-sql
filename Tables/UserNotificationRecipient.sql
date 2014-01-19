USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserNotificationRecipient]    Script Date: 01/08/2014 23:06:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserNotificationRecipient](
	[noticeId] [int] NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
	[hasRead] [bit] NOT NULL
) ON [PRIMARY]

GO

