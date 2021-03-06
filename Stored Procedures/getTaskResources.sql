USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskResources]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Get resources for this task
-- =============================================
CREATE PROCEDURE [dbo].[getTaskResources] 
	-- Add the parameters for the stored procedure here
	@taskId INT,
	@projectid INT,
	@userID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT
		TaskResource.id
		, TaskResource.qty
		, resourceName
		, supplierName = (
			SELECT supplierName
			FROM TaskResourceStack
			LEFT JOIN CatalogueUseage ON TaskResourceStack.catalogueResourceId = catalogueUseage.id
			LEFT JOIN Catalogue ON Catalogue.id = CatalogueUseage.catalogueId
			LEFT JOIN Supplier ON Catalogue.supplierId = Supplier.id
			WHERE TaskResourceStack.resourceID = TaskResource.resourceId AND projectId = @projectId
			GROUP BY supplierName
		)
		, resourceType
		, TaskResource.uses
		, unit
		, [Resource].waste
		,  TaskResource.uses*TaskResource.qty *
		(
			SELECT (SUM(TaskResourceStack.price)/SUM(TaskResourceStack.useage))*(1+(waste/100))
			FROM TaskResourceStack
			WHERE TaskResourceStack.resourceID = TaskResource.resourceId AND projectId = @projectId
			GROUP BY resourceId
		) AS cost
		, TaskResource.uses*TaskResource.qty *
			(
				SELECT SUM(TaskResourceStack.price/TaskResourceStack.useage)*(waste/100)
				FROM TaskResourceStack
				WHERE TaskResourceStack.resourceID = TaskResource.resourceId AND projectId = @projectId
				GROUP BY resourceId	
			) AS wasteCost
	FROM TaskResource
	LEFT JOIN [Resource] ON TaskResource.resourceId = [Resource].id
	LEFT JOIN ResourceType ON [Resource].resourceTypeId = resourceType.id
	LEFT JOIN ResourceUnit ON [Resource].unitId = ResourceUnit.ID
	WHERE taskId = @taskId
END
GO
