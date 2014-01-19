USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[TaskResourceStack]    Script Date: 01/08/2014 23:04:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TaskResourceStack](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[projectId] [int] NOT NULL,
	[resourceId] [int] NOT NULL,
	[catalogueResourceId] [int] NOT NULL,
	[qty] [float] NOT NULL,
	[price] [money] NOT NULL,
	[useage] [float] NOT NULL,
	[suffix] [varchar](50) NOT NULL,
	[lastUpdated] [datetime] NOT NULL,
	[productCode] [varchar](30) NOT NULL,
	[isLocked] [bit] NULL,
	[isEditable] [tinyint] NOT NULL,
	[incWaste] [bigint] NOT NULL,
 CONSTRAINT [PK_TaskResourceStack] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TaskResourceStack] ADD  CONSTRAINT [DF_TaskResourceStack_isLocked]  DEFAULT ((0)) FOR [isLocked]
GO

ALTER TABLE [dbo].[TaskResourceStack] ADD  CONSTRAINT [DF_TaskResourceStack_isEditable]  DEFAULT ((0)) FOR [isEditable]
GO

ALTER TABLE [dbo].[TaskResourceStack] ADD  CONSTRAINT [DF_TaskResourceStack_incWaste]  DEFAULT ((1)) FOR [incWaste]
GO

