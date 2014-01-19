USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[Resource]    Script Date: 01/08/2014 23:00:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Resource](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[resourceName] [nvarchar](255) NOT NULL,
	[manufacturer] [varchar](120) NULL,
	[partId] [varchar](50) NULL,
	[resourceTypeId] [int] NOT NULL,
	[categoryId] [int] NOT NULL,
	[unitId] [int] NOT NULL,
	[waste] [float] NOT NULL,
	[keywords] [varchar](255) NULL,
	[image] [varchar](50) NULL,
 CONSTRAINT [PK_Resource] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Resource] ADD  CONSTRAINT [DF_Resource_waste]  DEFAULT ((0)) FOR [waste]
GO

