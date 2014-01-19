USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[TaskData]    Script Date: 01/08/2014 23:03:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TaskData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskName] [varchar](500) NOT NULL,
	[keywords] [varchar](800) NOT NULL,
	[parentId] [int] NULL,
	[sequence] [int] NULL,
	[unitId] [int] NULL,
	[buildPhaseId] [int] NULL,
	[minutes] [float] NULL,
	[hidden] [tinyint] NOT NULL,
 CONSTRAINT [PK_TaskData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TaskData] ADD  CONSTRAINT [DF_TaskData_hidden]  DEFAULT ((0)) FOR [hidden]
GO

