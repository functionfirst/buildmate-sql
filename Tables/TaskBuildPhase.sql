USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[TaskBuildPhase]    Script Date: 01/08/2014 23:03:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TaskBuildPhase](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[buildPhase] [nvarchar](255) NULL,
	[buildSequence] [int] NULL,
	[stagePayments] [int] NULL,
 CONSTRAINT [PK_TaskBuildPhase] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

