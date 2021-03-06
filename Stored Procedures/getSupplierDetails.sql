USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSupplierDetails]    Script Date: 01/08/2014 21:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 11th August 2011
-- Description:	Get supplier details
-- =============================================
CREATE PROCEDURE [dbo].[getSupplierDetails] 
	-- Add the parameters for the stored procedure here
	@supplierId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Supplier.id, supplierName, tel, fax, email, url, [address], postcode, userId, isNull(global, 0) AS global
	FROM Supplier
	WHERE Supplier.id = @supplierId
END
GO
