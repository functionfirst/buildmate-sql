USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[UserSubscriptionLog]    Script Date: 01/08/2014 23:07:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserSubscriptionLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ActionDescription] [varchar](255) NOT NULL,
	[LogDate] [datetime] NOT NULL,
	[UserIPAddress] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UserSubscriptionLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[UserSubscriptionLog] ADD  CONSTRAINT [DF_UserSubscriptionLog_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO

