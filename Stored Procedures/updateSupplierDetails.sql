USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateSupplierDetails]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Update supplier details
-- =============================================
CREATE PROCEDURE [dbo].[updateSupplierDetails] 
	-- Add the parameters for the stored procedure here
	@supplierName varchar(50),
	@address varchar(255),
	@postcode varchar(8),
	@email varchar(120),
	@tel varchar(20),
	@fax varchar(20),
	@url varchar(50),
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE Supplier
	SET
		supplierName = @supplierName,
		[address] = @address,
		 postcode = @postcode,
		 email = @email,
		 tel = @tel,
		 fax = @fax,
		 url = @url
	WHERE id = @id
END
GO
