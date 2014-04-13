USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserProfile]    Script Date: 01/08/2014 23:06:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserProfile](
	[userid] [uniqueidentifier] NOT NULL,
	[name] [varchar](50) NULL,
	[titleid] [int] NULL,
	[firstname] [varchar](80) NULL,
	[surname] [varchar](80) NULL,
	[company] [varchar](120) NULL,
	[jobtitle] [varchar](120) NULL,
	[businessTypeId] [int] NULL,
	[address] [varchar](255) NULL,
	[address1] [varchar](50) NULL,
	[address2] [varchar](50) NULL,
	[address3] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[county] [varchar](20) NULL,
	[postcode] [varchar](8) NULL,
	[countryId] [int] NULL,
	[tel] [varchar](20) NULL,
	[fax] [varchar](20) NULL,
	[mobile] [varchar](20) NULL,
	[business] [varchar](20) NULL,
	[extension] [varchar](8) NULL,
	[email] [varchar](120) NULL,
	[logo] [varchar](120) NULL,
	[help] [bit] NULL,
	[tooltips] [bit] NULL,
	[subscriptionType] [tinyint] NOT NULL,
	[subscription] [datetime] NULL,
	[paypalPayerID] [varchar](20) NULL,
	[vat] [float] NULL,
	[vatnumber] [varchar](20) NULL,
	[notifyByEmail] [bit] NOT NULL,
	[notifyDate] [datetime] NULL,
	[avatar] [varchar](50) NULL,
	[token] [varchar](10) NULL
 CONSTRAINT [PK_UserProfile] PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_logo]  DEFAULT ('blank.gif') FOR [logo]
GO

ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_help]  DEFAULT ((0)) FOR [help]
GO

ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_tooltips]  DEFAULT ((0)) FOR [tooltips]
GO

ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_subscriptionType]  DEFAULT ((0)) FOR [subscriptionType]
GO

ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_notifyByEmail]  DEFAULT ((1)) FOR [notifyByEmail]
GO

