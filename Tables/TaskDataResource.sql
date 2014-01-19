USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[TaskDataResource]    Script Date: 01/08/2014 23:04:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TaskDataResource](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskDataId] [int] NOT NULL,
	[resourceId] [int] NOT NULL,
	[uses] [float] NOT NULL,
	[qty] [int] NOT NULL,
 CONSTRAINT [PK_TaskDataResource] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

