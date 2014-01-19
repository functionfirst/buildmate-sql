USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserNotification]    Script Date: 01/08/2014 23:05:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserNotification](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[supplierId] [int] NOT NULL,
	[categoryId] [int] NOT NULL,
	[title] [varchar](120) NOT NULL,
	[description] [varchar](255) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[sendDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserNotification] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

