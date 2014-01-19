USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserSubscriptionType]    Script Date: 01/08/2014 23:07:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserSubscriptionType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subscription] [varchar](50) NOT NULL,
	[billingAmount] [money] NOT NULL,
	[billingFrequency] [tinyint] NOT NULL,
	[billingPeriod] [varchar](50) NULL,
 CONSTRAINT [PK_UserSubscriptionType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[UserSubscriptionType] ADD  CONSTRAINT [DF_UserSubscriptionType_billingFrequency]  DEFAULT ((1)) FOR [billingFrequency]
GO

