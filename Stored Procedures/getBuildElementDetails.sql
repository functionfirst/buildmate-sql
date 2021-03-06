USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getBuildElementDetails]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 11th August 2011
-- Description:	Returns total cost of the selected element
-- =============================================
CREATE PROCEDURE [dbo].[getBuildElementDetails] 
	-- Add the parameters for the stored procedure here
	@buildElementId INT,
	@projectId INT,
	@userID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @buildCost MONEY, @adhocCost MONEY
	SET @buildCost = 0
	SET @adhocCost = 0

    -- Check for build cost
	DECLARE @sum AS TABLE(
		buildCost FLOAT
	)
	INSERT INTO @sum(buildCost)
	--SELECT
	--	isNull(
	--		(TaskResource.uses*TaskResource.qty*Task.qty)*
	--		SUM(TaskResourceStack.price)/SUM(TaskResourceStack.useage)
	--		*(1+(waste/100))
	--	, 0) AS buildCost
	--FROM TaskResource
	--LEFT JOIN TaskResourceStack ON TaskResource.resourceId = TaskResourceStack.resourceId
	--LEFT JOIN [Resource] ON TaskResourceStack.resourceId= [Resource].id
	--LEFT JOIN CatalogueUseage ON TaskResourceStack.catalogueResourceId = CatalogueUseage.id
	--LEFT JOIN Task ON TaskResource.taskId = Task.id
	--LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	--LEFT JOIN Project ON BuildElement.projectId = Project.id
	--WHERE BuildElement.id = @buildElementId AND Project.id = @projectId AND userID = @userID
	--GROUP BY
	--	buildElementId
	--	, TaskResource.id
	--	, TaskResource.qty
	--	, TaskResource.uses
	--	, waste
	--	, Task.qty
	--	, TaskResourceStack.resourceId
		
	SELECT
		isNull(
			(TaskResource.uses*TaskResource.qty*Task.qty) *
			(SELECT SUM(TaskResourceStack.price)/SUM(TaskResourceStack.useage)
			FROM TaskResourceStack
			WHERE projectId = @projectId AND resourceId = [Resource].id
			GROUP BY resourceId)
			*(1+(waste/100))
		, 0)
		AS unitCost
	FROM TaskResource
	LEFT JOIN [Resource] ON TaskResource.resourceId = [Resource].id
	LEFT JOIN Task ON Task.id= TaskResource.taskId
	LEFT JOIN BuildElement ON BuildElement.id = Task.BuildElementId
	LEFT JOIN Project ON Project.id = BuildElement.ProjectId
	WHERE BuildElement.id = @buildElementId AND Project.userId = @userId

	SELECT @buildCost = SUM(buildCost) FROM @sum
	
	-- Check for ad-hoc cost
	SELECT
		@adhocCost = isNull(sum(total), 0)
	FROM view_TaskAdditions
    WHERE userId = @userId AND buildElementId = @buildElementId

	-- return results
	SELECT 
		buildCost = isNull(@buildCost, 0) + isNull(@adhocCost, 0)
		, BuildElementType.spaceType
		, BuildElement.buildElementTypeId
		, BuildElementSundryItem.subcontractType
		, BuildElement.subcontractTypeId
		, BuildElement.id
		, BuildElement.spaceName
		, BuildElement.completion
		, BuildElement.spacePrice
		, BuildElement.subcontractPercent
		, BuildElement.completion
		, isLocked =
			CASE WHEN BuildElementType.isEditable <> ProjectStatus.isEditable THEN 'True'
			ELSE 'False'
			END
	FROM BuildElement
	LEFT JOIN Project ON BuildElement.projectId = Project.id
	LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	LEFT JOIN BuildElementSundryItem ON BuildElement.subcontractTypeId = BuildElementSundryItem.id
	WHERE BuildElement.id = @buildElementId
		AND Project.userId = @userId
END
GO
