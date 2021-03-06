USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectTenderTypes]    Script Date: 01/08/2014 21:36:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Get all Project Types
-- =============================================
CREATE PROCEDURE [dbo].[getProjectTenderTypes]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id, tenderType FROM ProjectTenderType
END
GO
