USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateCatalogueUseageDetailsById]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Update catalogue useage details for this id
-- =============================================
CREATE PROCEDURE [dbo].[updateCatalogueUseageDetailsById] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@resourceId INT,
	@productCode VARCHAR(30),
	@suffix VARCHAR(50),
	@price MONEY,
	@leadTime int,
	@discontinued BIT,
	@useage FLOAT,
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @projectId INT, @isEditable TINYINT

    UPDATE CatalogueUseage
    SET
		productCode=@productCode
		, suffix=@suffix
		, price=@price
		, leadTime=@leadTime
		, discontinued=@discontinued
		, lastUpdated=getdate()
		, useage=@useage
    WHERE id = @id
  
	-- run the resource stack for this resource across all projects
	-- pass 0 for @isEditable - we only want to update prices for Projects that are Unassigned/Estimating
	Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
END
GO
