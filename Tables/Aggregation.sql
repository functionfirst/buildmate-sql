USE [getbuild_mate]
GO
/****** Object:  Table [dbo].[Aggregation]    Script Date: 01/08/2014 21:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Aggregation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[aggregate] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
