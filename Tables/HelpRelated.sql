USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[HelpRelated]    Script Date: 01/08/2014 22:52:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HelpRelated](
	[helpId] [int] IDENTITY(1,1) NOT NULL,
	[relatedId] [int] NOT NULL,
 CONSTRAINT [PK_HelpRelated] PRIMARY KEY CLUSTERED 
(
	[helpId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

