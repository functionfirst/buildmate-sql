USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[ResourceCategory]    Script Date: 01/08/2014 23:00:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ResourceCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [varchar](120) NOT NULL,
	[catParent] [int] NULL,
 CONSTRAINT [PK_ResourceCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ResourceCategory] ADD  CONSTRAINT [DF_ResourceCategory_catParent]  DEFAULT ((0)) FOR [catParent]
GO

