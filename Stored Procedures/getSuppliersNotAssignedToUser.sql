USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSuppliersNotAssignedToUser]    Script Date: 01/08/2014 21:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get a list of global suppliers not currently in this user's supplier priority list.
-- =============================================
CREATE PROCEDURE [dbo].[getSuppliersNotAssignedToUser]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT id, supplierName
    FROM Supplier
    WHERE ([global] = 1 OR userId = @userId)
    AND Supplier.id NOT IN(
        SELECT supplierid
        FROM SupplierPriority
        WHERE userid = @userId
    )
    ORDER BY supplierName
END
GO
