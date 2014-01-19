USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[BuildElement]    Script Date: 01/08/2014 22:02:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[BuildElement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[projectId] [int] NOT NULL,
	[buildElementTypeId] [int] NOT NULL,
	[spaceName] [varchar](80) NOT NULL,
	[subcontractTypeId] [int] NOT NULL,
	[subcontractPercent] [smallint] NOT NULL,
	[spacePrice] [money] NOT NULL,
	[completion] [smallint] NOT NULL,
	[hidden] [bit] NOT NULL,
	[isLocked] [bit] NOT NULL,
 CONSTRAINT [PK_BuildElement] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[BuildElement] ADD  CONSTRAINT [DF_BuildElement_subcontractTypeId]  DEFAULT ((1)) FOR [subcontractTypeId]
GO

ALTER TABLE [dbo].[BuildElement] ADD  CONSTRAINT [DF_BuildElement_subcontractPercent]  DEFAULT ((0)) FOR [subcontractPercent]
GO

ALTER TABLE [dbo].[BuildElement] ADD  CONSTRAINT [DF_BuildElement_spacePrice]  DEFAULT ((0)) FOR [spacePrice]
GO

ALTER TABLE [dbo].[BuildElement] ADD  CONSTRAINT [DF_BuildElement_completion]  DEFAULT ((0)) FOR [completion]
GO

ALTER TABLE [dbo].[BuildElement] ADD  CONSTRAINT [DF_BuildElement_hidden]  DEFAULT ((0)) FOR [hidden]
GO

ALTER TABLE [dbo].[BuildElement] ADD  CONSTRAINT [DF_BuildElement_isLocked]  DEFAULT ((0)) FOR [isLocked]
GO

