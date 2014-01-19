USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[BuildElementSundryItem]    Script Date: 01/08/2014 22:50:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[BuildElementSundryItem](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subcontractType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_BuildElementSundryItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

