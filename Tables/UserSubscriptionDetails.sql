USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserSubscriptionDetails]    Script Date: 01/08/2014 23:06:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserSubscriptionDetails](
	[UserId] [uniqueidentifier] NULL,
	[Description] [varchar](50) NULL,
	[status] [varchar](20) NULL,
	[SubscriberName] [varchar](50) NULL,
	[ProfileReference] [varchar](50) NULL,
	[BillingPeriod] [varchar](20) NULL,
	[Amt] [float] NULL,
	[ProfileStartDate] [varchar](20) NULL,
	[LastPaymentDate] [varchar](20) NULL,
	[NextBillingDate] [varchar](20) NULL,
	[AutoBilloutAmt] [varchar](20) NULL,
	[MaxFailedPayments] [int] NULL,
	[BillingFrequency] [int] NULL,
	[TotalBillingCycles] [int] NULL,
	[NumCyclesCompleted] [int] NULL,
	[NumCyclesRemaining] [int] NULL,
	[OutstandingBalance] [float] NULL,
	[FailedPaymentCount] [int] NULL,
	[LastPaymentAmt] [float] NULL,
	[Acct] [varchar](50) NULL,
	[CreditCardType] [varchar](50) NULL,
	[ExpDate] [date] NULL,
	[IssueNumber] [int] NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Street] [varchar](50) NULL,
	[Street2] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[CountryCode] [int] NULL,
	[Zip] [varchar](10) NULL,
	[LastUpdated] [date] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[UserSubscriptionDetails] ADD  CONSTRAINT [DF_UserSubscriptionDetails_LastUpdated]  DEFAULT (getdate()) FOR [LastUpdated]
GO

