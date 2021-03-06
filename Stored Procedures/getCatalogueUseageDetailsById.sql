USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getCatalogueUseageDetailsById]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get catalogue useage details for this id
-- =============================================
CREATE PROCEDURE [dbo].[getCatalogueUseageDetailsById]
	-- Add the parameters for the stored procedure here
	@catalogueId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT  * FROM CatalogueUseage WHERE id = @catalogueId
END
GO
