USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertTaskResource]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 14th August 2008
-- Description:	Inserts new task resource but will update 
--				if the catalogue resource already exists
-- =============================================
CREATE PROCEDURE [dbo].[insertTaskResource]
	-- Add the parameters for the stored procedure here
	@taskId INT,
	@projectId INT,
	@resourceId INT,
	@userId UNIQUEIDENTIFIER,
	@uses FLOAT,
	@qty INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @catalogueId INT
		, @price INT
		, @useage FLOAT
		, @suffix VARCHAR(80)
		, @lastUpdated DATETIME
		, @productCode VARCHAR(30)
		, @oldUses INT

	-- get the top resource
    -- get the supplier priority listing
	SELECT TOP 1
		@catalogueId = CatalogueUseage.catalogueId
		, @price = price
		, @useage = useage
		, @suffix = suffix
		, @lastUpdated = lastUpdated
		, @productCode = productCode
	FROM Catalogue
	LEFT JOIN CatalogueUseage ON CatalogueUseage.catalogueId = Catalogue.id
	LEFT JOIN Resource ON Catalogue.resourceId = Resource.id
	LEFT JOIN SupplierPriority ON SupplierPriority.supplierId = Catalogue.supplierId
	WHERE discontinued = 0 AND SupplierPriority.userId = @userId AND resourceId = @resourceId
	ORDER BY position
	
	-- if this resource already exists there will be some existing uses we can use
	SELECT @oldUses = uses
	FROM TaskResource
	WHERE taskId = @taskId AND resourceId = @resourceId
	
	-- get isEditable from parent Build Element
	DECLARE @isEditable TINYINT
	SELECT @isEditable = isEditable
	FROM BuildElement
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	LEFT JOIN Task ON Task.buildElementId = BuildElement.id
	WHERE Task.id= @taskId
    
	-- check if the resource already exists
	-- we just want to update it if it is
    IF @oldUses is not null
		-- resource does exist so update data
		BEGIN
			UPDATE TaskResource
			SET uses = @uses + @oldUses, qty = @qty
			WHERE taskId = @taskId AND resourceId = @resourceId
		END
	ELSE
		BEGIN
			-- resource is new so insert it
			INSERT INTO TaskResource (taskId, resourceId, uses, qty)
			VALUES(@taskId, @resourceId, @uses, @qty)
		END
	
	-- check to make sure a resource was added before we update the stack
	IF NOT @resourceId IS NULL
	BEGIN	
		-- update resource stack
		Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
	END
END
GO
