USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[CatalogueUseage]    Script Date: 01/08/2014 22:51:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CatalogueUseage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[catalogueId] [int] NOT NULL,
	[productCode] [varchar](30) NOT NULL,
	[price] [money] NOT NULL,
	[leadTime] [int] NOT NULL,
	[discontinued] [bit] NOT NULL,
	[lastUpdated] [datetime] NOT NULL,
	[useage] [float] NOT NULL,
	[suffix] [varchar](50) NULL,
 CONSTRAINT [PK_CatalogueUseage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[CatalogueUseage] ADD  CONSTRAINT [DF_CatalogueUseage_discontinued]  DEFAULT ((0)) FOR [discontinued]
GO

