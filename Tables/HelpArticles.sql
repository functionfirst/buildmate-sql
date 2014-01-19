USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[HelpArticles]    Script Date: 01/08/2014 22:51:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[HelpArticles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[helpTitle] [varchar](255) NULL,
	[helpContent] [text] NULL,
	[helpKeywords] [varchar](255) NULL,
	[hitcount] [int] NOT NULL,
	[parentId] [int] NULL,
	[pagename] [varchar](50) NULL,
 CONSTRAINT [PK_HelpArticles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

