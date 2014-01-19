USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[Catalogue]    Script Date: 01/08/2014 22:51:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Catalogue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[supplierId] [int] NOT NULL,
	[resourceId] [int] NOT NULL,
 CONSTRAINT [PK_Catalogue] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

