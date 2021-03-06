USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getResourceUnits]    Script Date: 01/08/2014 21:36:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 3rd November 2011
-- Description:	Get resource units
-- =============================================
CREATE PROCEDURE [dbo].[getResourceUnits] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM ResourceUnit ORDER BY unit
END
GO
