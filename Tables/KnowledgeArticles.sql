USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[KnowledgeArticles]    Script Date: 01/08/2014 22:52:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KnowledgeArticles](
	[KnowledgeArticleId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Title] [varchar](120) NOT NULL,
	[Keywords] [varchar](255) NULL,
	[Article] [varchar](1500) NOT NULL,
	[ViewCount] [int] NOT NULL,
	[Attachment] [varchar](50) NULL,
	[DateModified] [date] NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[Hidden] [bit] NULL,
	[KnowledgeCategory_KnowledgeCategoryId] [int] NULL,
 CONSTRAINT [PK_KnowledgeArticles] PRIMARY KEY CLUSTERED 
(
	[KnowledgeArticleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[KnowledgeArticles] ADD  CONSTRAINT [DF_KnowledgeArticles_ViewCount]  DEFAULT ((0)) FOR [ViewCount]
GO

ALTER TABLE [dbo].[KnowledgeArticles] ADD  CONSTRAINT [DF_KnowledgeArticles_DateModified]  DEFAULT (getdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[KnowledgeArticles] ADD  CONSTRAINT [DF_KnowledgeArticles_DateAdded]  DEFAULT (getdate()) FOR [DateAdded]
GO

ALTER TABLE [dbo].[KnowledgeArticles] ADD  CONSTRAINT [DF_KnowledgeArticles_Hidden]  DEFAULT ((0)) FOR [Hidden]
GO

