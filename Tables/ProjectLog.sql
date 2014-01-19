USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[ProjectLog]    Script Date: 01/08/2014 22:58:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ProjectLog](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[userId] [uniqueidentifier] NULL,
	[statusId] [int] NULL,
	[projectId] [bigint] NULL,
	[note] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
 CONSTRAINT [PK_ProjectLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ProjectLog] ADD  CONSTRAINT [DF_ProjectLog_date]  DEFAULT (getdate()) FOR [created_at]
GO

