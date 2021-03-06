USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertSupplier]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd October 2011
-- Description:	Insert new supplier for this user
-- =============================================
CREATE PROCEDURE [dbo].[insertSupplier] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@supplierName VARCHAR(50),
	@address VARCHAR(255),
	@postcode VARCHAR(8),
	@email VARCHAR(120),
	@tel VARCHAR(20),
	@fax VARCHAR(20),
	@url VARCHAR(50),
	@isLocked BIT = 0,
	@NewId INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	DECLARE @supplierId INT, @pos INT

    -- get latest supplier position
    SELECT TOP 1 @pos = position
    FROM SupplierPriority
    WHERE userId = @UserId
    ORDER BY position DESC;
    
    -- increment the last position
    SET @pos = @pos+1;
    
    -- insert new supplier
    DECLARE @isGlobal BIT;
    SET @isGlobal = 0;
    INSERT INTO Supplier (userId, supplierName, tel, fax, email, url, [address], postcode, [global])
    VALUES(@userId, @supplierName, @tel, @fax, @email, @url, @address, @postcode, @isGlobal);

    SELECT @supplierId = SCOPE_IDENTITY();

	-- insert new supplier position (at the end)
	IF NOT @supplierId IS NULL
	BEGIN
		INSERT INTO SupplierPriority(userId, supplierId, position, isLocked) VALUES(@userId, @supplierId, @pos, @isLocked);
		
		SELECT @NewId = @supplierId;
	END
	
END
GO
