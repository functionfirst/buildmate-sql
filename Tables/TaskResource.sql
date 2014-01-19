USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[TaskResource]    Script Date: 01/08/2014 23:04:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TaskResource](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskId] [int] NOT NULL,
	[resourceId] [int] NOT NULL,
	[uses] [float] NOT NULL,
	[qty] [int] NOT NULL,
 CONSTRAINT [PK_TaskResource] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

