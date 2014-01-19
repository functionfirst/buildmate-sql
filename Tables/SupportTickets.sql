USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[SupportTickets]    Script Date: 01/08/2014 23:01:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SupportTickets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
	[subject] [varchar](50) NULL,
	[content] [varchar](1000) NOT NULL,
	[dateCreated] [datetime] NOT NULL,
	[isLocked] [bit] NOT NULL,
 CONSTRAINT [PK_SupportTickets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

