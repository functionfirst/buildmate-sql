USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[BuildElementType]    Script Date: 01/08/2014 22:50:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[BuildElementType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[spaceType] [varchar](50) NOT NULL,
	[isLocked] [bit] NOT NULL,
	[isEditable] [tinyint] NOT NULL,
 CONSTRAINT [PK_BuildElementType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[BuildElementType] ADD  CONSTRAINT [DF_BuildElementType_isEditable]  DEFAULT ((0)) FOR [isEditable]
GO

