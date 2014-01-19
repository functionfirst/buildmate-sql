USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[TaskGlobalCalculation]    Script Date: 01/08/2014 23:04:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TaskGlobalCalculation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](80) NULL,
	[taskId] [int] NULL,
	[linked] [bit] NULL,
 CONSTRAINT [PK_TaskGlobalCalculation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

