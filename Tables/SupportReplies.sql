USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[SupportReplies]    Script Date: 01/08/2014 23:01:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SupportReplies](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ticketId] [int] NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
	[repContent] [varchar](1000) NOT NULL,
	[repDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SupportReplies] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

