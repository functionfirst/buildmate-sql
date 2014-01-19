USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[Project]    Script Date: 01/08/2014 22:58:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Project](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userID] [uniqueidentifier] NOT NULL,
	[projectName] [nvarchar](150) NOT NULL,
	[projectTypeId] [int] NOT NULL,
	[description] [text] NULL,
	[customerId] [bigint] NOT NULL,
	[projectStatusId] [tinyint] NOT NULL,
	[startDate] [datetime] NULL,
	[completionDate] [datetime] NULL,
	[retentionPeriod] [tinyint] NOT NULL,
	[retentionTypeId] [tinyint] NOT NULL,
	[retentionPercentage] [tinyint] NOT NULL,
	[overhead] [float] NOT NULL,
	[profit] [float] NOT NULL,
	[tenderTypeId] [int] NOT NULL,
	[returnDate] [datetime] NOT NULL,
	[incVAT] [bit] NOT NULL,
	[vatRate] [float] NOT NULL,
	[incDiscount] [bit] NOT NULL,
	[hidden] [bit] NOT NULL,
	[archived] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NOT NULL,
	[wonlost] [tinyint] NOT NULL,
	[wonlost_at] [datetime] NULL,
	[modified_by] [uniqueidentifier] NULL,
	[created_by] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_retentionPeriod]  DEFAULT ((0)) FOR [retentionPeriod]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_retentionTypeId]  DEFAULT ((1)) FOR [retentionTypeId]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_retentionPercentage]  DEFAULT ((0)) FOR [retentionPercentage]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_overhead]  DEFAULT ((0)) FOR [overhead]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_profit]  DEFAULT ((0)) FOR [profit]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_tenderTypeId]  DEFAULT ((1)) FOR [tenderTypeId]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_incVAT]  DEFAULT ((0)) FOR [incVAT]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_vatRate]  DEFAULT ((0)) FOR [vatRate]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_incDiscount]  DEFAULT ((0)) FOR [incDiscount]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_hidden]  DEFAULT ((0)) FOR [hidden]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_archived]  DEFAULT ((0)) FOR [archived]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_creationDate]  DEFAULT (getdate()) FOR [created_at]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_lastModified]  DEFAULT (getdate()) FOR [modified_at]
GO

ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF_Project_lost]  DEFAULT ((0)) FOR [wonlost]
GO

