USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[KnowledgeRating]    Script Date: 01/08/2014 22:53:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KnowledgeRating](
	[KnowledgeArticleId] [int] IDENTITY(1,1) NOT NULL,
	[Promote] [bit] NOT NULL,
 CONSTRAINT [PK_KnowledgeRating] PRIMARY KEY CLUSTERED 
(
	[KnowledgeArticleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

