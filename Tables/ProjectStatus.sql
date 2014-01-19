USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[ProjectStatus]    Script Date: 01/08/2014 22:59:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ProjectStatus](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[status] [varchar](30) NOT NULL,
	[setorder] [int] NOT NULL,
	[isLocked] [bit] NULL,
	[isEditable] [tinyint] NOT NULL,
 CONSTRAINT [PK_ProjectStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ProjectStatus] ADD  CONSTRAINT [DF_ProjectStatus_isEditable]  DEFAULT ((0)) FOR [isEditable]
GO

