USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectStatusList]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[getProjectStatusList]
AS
	Select id, status FROM tblStatus
GO
