USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserContact]    Script Date: 01/08/2014 23:05:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserContact](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [uniqueidentifier] NULL,
	[name] [varchar](255) NULL,
	[titleId] [int] NULL,
	[firstname] [varchar](80) NULL,
	[surname] [varchar](80) NULL,
	[company] [varchar](80) NULL,
	[jobtitle] [varchar](80) NULL,
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
	[mobile] [varchar](20) NULL,
	[business] [varchar](20) NULL,
	[extension] [varchar](8) NULL,
	[email] [varchar](120) NULL,
	[paymentTermsId] [int] NOT NULL,
	[archived] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NOT NULL,
 CONSTRAINT [PK_UserContact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[UserContact] ADD  CONSTRAINT [DF_UserContact_archived]  DEFAULT ((0)) FOR [archived]
GO

ALTER TABLE [dbo].[UserContact] ADD  CONSTRAINT [DF_UserContact_created_at]  DEFAULT (getdate()) FOR [created_at]
GO

ALTER TABLE [dbo].[UserContact] ADD  CONSTRAINT [DF_UserContact_modified_at]  DEFAULT (getdate()) FOR [modified_at]
GO

