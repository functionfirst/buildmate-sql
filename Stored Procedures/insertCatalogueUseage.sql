USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertCatalogueUseage]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 10th March 2011
-- Description:	Create a supplier/resource relationship then create a catalogue/useage to match.
-- =============================================
CREATE PROCEDURE [dbo].[insertCatalogueUseage]
	-- Add the parameters for the stored procedure here
	@resourceId INT,
	@supplierId INT,
	@productCode VARCHAR(30),
	@suffix VARCHAR(50),
	@price MONEY,
	@leadTime INT,
	@discontinued BIT,
	@useage FLOAT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @catalogueId INT

    -- Insert statements for procedure here
    INSERT INTO Catalogue (resourceId, supplierId) VALUES(@resourceId, @supplierId); 
	SELECT @catalogueId = SCOPE_IDENTITY()
	
	If @catalogueId >=1
	BEGIN
		INSERT INTO CatalogueUseage(catalogueId,	productCode, suffix, price, leadTime, discontinued, lastUpdated, useage)
		VALUES(@catalogueId,@productCode, @suffix, @price, @leadTime, @discontinued, getdate(), @useage)
	END
END
GO
