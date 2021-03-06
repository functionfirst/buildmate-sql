USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getCatalogueUseageByResourceAndUser]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get a list of catalogue users for this user's resource
-- =============================================
CREATE PROCEDURE [dbo].[getCatalogueUseageByResourceAndUser]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@resourceId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		CatalogueUseage.id AS id
		, resourceId
		, isnull(discontinued, 0) AS discontinued
		, supplierName
		, productCode
		, price
		, leadTime
		, lastUpdated
		, useage
		, suffix
	FROM Catalogue
	RIGHT JOIN CatalogueUseage ON Catalogue.id = CatalogueUseage.catalogueId
	RIGHT JOIN Supplier ON Catalogue.supplierId = Supplier.id 
	WHERE resourceId = @resourceid AND userId = @userId
END
GO
