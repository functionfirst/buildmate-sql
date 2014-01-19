USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[SystemNotification]    Script Date: 01/08/2014 23:02:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SystemNotification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](120) NOT NULL,
	[Abstract] [varchar](255) NULL,
	[URL] [varchar](120) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateStart] [datetime] NOT NULL,
	[Hidden] [tinyint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[SystemNotification] ADD  CONSTRAINT [DF_SystemNotification_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[SystemNotification] ADD  CONSTRAINT [DF_SystemNotification_hidden]  DEFAULT ((0)) FOR [Hidden]
GO

