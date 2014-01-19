USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserNotificationCategory]    Script Date: 01/08/2014 23:05:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserNotificationCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UserNotificationCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

