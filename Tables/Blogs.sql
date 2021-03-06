USE [getbuild_mate]
GO
/****** Object:  Table [dbo].[Blogs]    Script Date: 01/08/2014 21:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Blogs](
	[BlogId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[Abstract] [varchar](255) NULL,
	[Keywords] [varchar](255) NULL,
	[Article] [varchar](5000) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Hidden] [bit] NOT NULL,
	[BlogCategory_BlogCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
