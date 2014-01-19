USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[ProjectRetentionType]    Script Date: 01/08/2014 22:59:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ProjectRetentionType](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[retentionType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ProjectRetentionType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

