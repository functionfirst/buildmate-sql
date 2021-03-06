USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSupplierPriorityListByUserId]    Script Date: 01/08/2014 21:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description: Get a list of suppliers in the users's supplier priority list
-- =============================================
CREATE PROCEDURE [dbo].[getSupplierPriorityListByUserId]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT
		SupplierPriority.id
		, isLocked
		, Supplier.userId
		, Supplier.supplierName
		, SupplierPriority.position
		, Supplier.id AS supplierId
	FROM Supplier
	LEFT JOIN SupplierPriority ON Supplier.id = SupplierPriority.supplierId
	WHERE (SupplierPriority.userId = @UserId) AND supplierId > 1
	ORDER BY position DESC
END
GO
