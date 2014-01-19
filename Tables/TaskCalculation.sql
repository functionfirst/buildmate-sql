USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[TaskCalculation]    Script Date: 01/08/2014 23:03:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TaskCalculation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[globalId] [bigint] NULL,
	[calcId] [bigint] NOT NULL,
	[length] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[multiplier] [float] NOT NULL,
	[global] [bit] NOT NULL,
	[subtract] [tinyint] NOT NULL,
	[comment] [varchar](50) NULL,
 CONSTRAINT [PK_TaskCalculation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TaskCalculation] ADD  CONSTRAINT [DF_TaskCalculation_calcId]  DEFAULT ((0)) FOR [calcId]
GO

ALTER TABLE [dbo].[TaskCalculation] ADD  CONSTRAINT [DF_TaskCalculation_length]  DEFAULT ((1)) FOR [length]
GO

ALTER TABLE [dbo].[TaskCalculation] ADD  CONSTRAINT [DF_TaskCalculation_width]  DEFAULT ((1)) FOR [width]
GO

ALTER TABLE [dbo].[TaskCalculation] ADD  CONSTRAINT [DF_TaskCalculation_height]  DEFAULT ((1)) FOR [height]
GO

ALTER TABLE [dbo].[TaskCalculation] ADD  CONSTRAINT [DF_TaskCalculation_multiplier]  DEFAULT ((1)) FOR [multiplier]
GO

ALTER TABLE [dbo].[TaskCalculation] ADD  CONSTRAINT [DF_TaskCalculation_global]  DEFAULT ((0)) FOR [global]
GO

