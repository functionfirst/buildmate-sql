USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[TaskAddition]    Script Date: 01/08/2014 23:02:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TaskAddition](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskId] [int] NOT NULL,
	[description] [varchar](255) NOT NULL,
	[price] [money] NOT NULL,
	[percentage] [float] NOT NULL,
	[adhocTypeId] [tinyint] NULL,
 CONSTRAINT [PK_TaskAddition] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

