USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[aspnet_Users]    Script Date: 01/08/2014 22:49:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[aspnet_Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[LoweredUserName] [nvarchar](256) NOT NULL,
	[MobileAlias] [nvarchar](16) NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
 CONSTRAINT [PK_aspnet_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[aspnet_Users] ADD  CONSTRAINT [DF_aspnet_Users_UserId]  DEFAULT (newid()) FOR [UserId]
GO

ALTER TABLE [dbo].[aspnet_Users] ADD  CONSTRAINT [DF_aspnet_Users_IsAnonymous]  DEFAULT ((0)) FOR [IsAnonymous]
GO

