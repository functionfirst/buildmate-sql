USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[initialSupplierPriority]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd October 2011
-- Description:	Add default supplier priority list
-- =============================================
CREATE PROCEDURE [dbo].[initialSupplierPriority]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO SupplierPriority(userId, supplierId, position, isLocked)
	SELECT thisUserId = @userId, id, id, 1 FROM Supplier WHERE id = 1
END
GO
