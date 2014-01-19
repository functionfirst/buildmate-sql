USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[Task]    Script Date: 01/08/2014 23:02:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Task](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskDataId] [int] NOT NULL,
	[buildElementId] [int] NOT NULL,
	[parentId] [int] NULL,
	[buildPhaseId] [int] NOT NULL,
	[taskTime] [int] NULL,
	[qty] [float] NOT NULL,
	[actualMinutes] [int] NOT NULL,
	[percentComplete] [smallint] NOT NULL,
	[note] [text] NULL,
	[isLocked] [bit] NOT NULL,
	[isDefaultResource] [bit] NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_actualMinutes]  DEFAULT ((0)) FOR [actualMinutes]
GO

ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_isLocked]  DEFAULT ((0)) FOR [isLocked]
GO

ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_isDefaultResource]  DEFAULT ((0)) FOR [isDefaultResource]
GO

