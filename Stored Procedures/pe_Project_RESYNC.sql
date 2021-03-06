USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[pe_Project_RESYNC]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 20th August 2011
-- Description:	Resynchronise catalogue resources in a Project with their original resource
-- =============================================
CREATE PROCEDURE [dbo].[pe_Project_RESYNC]
	-- Add the parameters for the stored procedure here
	@userID UNIQUEIDENTIFIER,
	@pid INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @id char(11), @resourceId INT
	
	DECLARE @price MONEY, @catalogueId INT, @useage FLOAT, @suffix VARCHAR(50), @lastUpdated DATETIME, @productCode VARCHAR(50)

	-- get first record pointer
	SELECT
		@id = min(tblTaskResources.id)
	FROM tblTaskResources
	INNER JOIN tblTasks ON tblTaskResources.taskId = tblTasks.id
	INNER JOIN tblSpaces ON tblTasks.roomId = tblSpaces.id
	INNER JOIN tblProjects ON tblProjects.id = tblSpaces.projectId
	WHERE userID = @userID AND projectId = @pid

	WHILE @id is not null
	BEGIN
		-- get the current resource Id
		SELECT @resourceId = resourceId FROM tblTaskResources WHERE id = @id
	
		-- get new catalogue/resource details
		SELECT TOP 1
			@price = price
			, @catalogueid = catalogueId
			, @useage = useage
			, @suffix = suffix
			, @lastUpdated=lastUpdated
			, @productCode = productCode
		FROM tblCatalogue
		LEFT JOIN tblSupplierPriority ON tblCatalogue.supplierId = tblSupplierPriority.supplierId
		LEFT JOIN tblCatalogueUseage ON tblCatalogue.id = tblCatalogueUseage.catalogueId
		WHERE
			tblCatalogue.resourceId = @resourceId
			AND tblSupplierPriority.userId = @userId
			AND tblCatalogueUseage.discontinued = 0
		ORDER BY tblSupplierPriority.position, tblCatalogueUseage.useage
		
		UPDATE tblTaskResources SET
			price = @price
			, catalogueId = @catalogueId
			, useage = @useage
			, suffix = @suffix
			, lastUpdated = @lastUpdated
			, productCode = @productCode
		WHERE tblTaskResources.id = @id
		
		-- move to next record
		SELECT @id = MIN(tblTaskResources.id)
		FROM tblTaskResources
		INNER JOIN tblTasks ON tblTaskResources.taskId = tblTasks.id
		INNER JOIN tblSpaces ON tblTasks.roomId = tblSpaces.id
		INNER JOIN tblProjects ON tblProjects.id = tblSpaces.projectId
		WHERE tblTaskResources.id > @id
		AND userID = @userID AND projectId = @pid
	END
END
GO
