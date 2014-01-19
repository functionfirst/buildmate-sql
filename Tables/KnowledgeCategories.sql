USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[KnowledgeCategories]    Script Date: 01/08/2014 22:52:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KnowledgeCategories](
	[KnowledgeCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](120) NOT NULL,
	[Keywords] [varchar](255) NULL,
	[Description] [varchar](255) NULL,
 CONSTRAINT [PK_KnowledgeCategories] PRIMARY KEY CLUSTERED 
(
	[KnowledgeCategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

