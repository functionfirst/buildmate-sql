USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[Supplier]    Script Date: 01/08/2014 23:00:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Supplier](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [uniqueidentifier] NULL,
	[supplierName] [varchar](50) NOT NULL,
	[address] [varchar](255) NULL,
	[address1] [varchar](50) NULL,
	[address2] [varchar](50) NULL,
	[address3] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[county] [varchar](50) NULL,
	[postcode] [varchar](8) NULL,
	[countryId] [int] NULL,
	[tel] [varchar](20) NULL,
	[fax] [varchar](20) NULL,
	[email] [varchar](120) NULL,
	[url] [varchar](50) NULL,
	[global] [bit] NOT NULL,
	[avatar] [varchar](50) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Supplier] ADD  CONSTRAINT [DF_Supplier_global]  DEFAULT ((0)) FOR [global]
GO

