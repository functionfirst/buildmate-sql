USE [getbuild_mate]
GO

/****** Object:  Table [dbo].[ProjectPaymentTerm]    Script Date: 01/08/2014 22:58:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ProjectPaymentTerm](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[paymentTerm] [varchar](255) NOT NULL,
 CONSTRAINT [PK_ProjectPaymentTerm] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
