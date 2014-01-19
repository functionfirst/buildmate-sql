USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[SupplierPriority]    Script Date: 01/08/2014 23:01:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SupplierPriority](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[userID] [uniqueidentifier] NOT NULL,
	[supplierId] [int] NOT NULL,
	[position] [float] NOT NULL,
	[isLocked] [bit] NOT NULL,
 CONSTRAINT [PK_SupplierPriority] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[SupplierPriority] ADD  CONSTRAINT [DF_SupplierPriority_position]  DEFAULT ((0)) FOR [position]
GO

ALTER TABLE [dbo].[SupplierPriority] ADD  CONSTRAINT [DF_SupplierPriority_isLocked]  DEFAULT ((0)) FOR [isLocked]
GO

