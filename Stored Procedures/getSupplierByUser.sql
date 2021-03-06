USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSupplierByUser]    Script Date: 01/08/2014 21:36:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get this user's custom suppliers
-- =============================================
CREATE PROCEDURE [dbo].[getSupplierByUser] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM Supplier WHERE userId = @userId
END
GO
