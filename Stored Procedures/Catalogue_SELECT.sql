USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[Catalogue_SELECT]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 19th September 2011
-- Description:	Retrieve catalogue and resource data for
--				the supplier/resource combination provided.
-- =============================================
CREATE PROCEDURE [dbo].[Catalogue_SELECT]
	-- Add the parameters for the stored procedure here
	@resourceId BIGINT,
	@supplierId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT tblCatalogueUseage.id, catalogueId, resourceName,
		productCode, suffix, price, tblCatalogueUseage.useage, leadTime, lastUpdated,
		NULLIF(discontinued, 0) AS discontinued
	FROM tblResources, tblCatalogue, tblCatalogueUseage
	WHERE tblCatalogue.resourceId = @resourceId
	AND tblCatalogue.supplierId = @supplierId
	AND tblResources.id = tblCatalogue.resourceId
	AND tblCatalogueUseage.catalogueId = tblCatalogue.id
END
GO
