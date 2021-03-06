USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getBuildElementsByProjectAndUser]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 14th August 20011
-- Description:	Select all Spaces for the selected project
-- =============================================
CREATE PROCEDURE [dbo].[getBuildElementsByProjectAndUser]
	-- Add the parameters for the stored procedure here
	@userID UNIQUEIDENTIFIER,
	@projectId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- get buildCost of each build element
	DECLARE @useage AS TABLE(
		buildElementId INT
		, totalUseage FLOAT
	)
	DECLARE @cost AS TABLE(
		buildElementId INT
		, unitCost FLOAT
	)
	INSERT INTO @useage(buildElementId, totalUseage)
	select BuildElement.id, SUM(qty*useage) AS totalUseage
	FROM TaskResourceStack
	LEFT JOIN BuildElement ON BuildElement.projectId = TaskResourceStack.projectId
	WHERE TaskResourceStack.projectId = @projectId
	GROUP BY BuildElement.id
	
	-- get buildCost of each build element
	DECLARE @sum AS TABLE(
		buildElementId INT
		, buildCost FLOAT
	)
	INSERT INTO @sum(buildElementId, buildCost)
	SELECT buildElementId, 
		(TaskResource.uses*TaskResource.qty*Task.qty) *
		(
			SELECT SUM(TaskResourceStack.price)/SUM(TaskResourceStack.useage)
			FROM TaskResourceStack
			WHERE projectId = @projectId AND resourceId = [Resource].id
			GROUP BY resourceId
		) * (1+(waste/100))
		AS buildCost
	FROM TaskResource
	LEFT JOIN [Resource] ON TaskResource.resourceId = [Resource].id
	LEFT JOIN Task ON Task.id= TaskResource.taskId
	LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	LEFT JOIN Project ON BuildElement.projectId = Project.id
	WHERE Project.id = @projectId AND userID = @userID
	
	-- get build elements
	SELECT
		projectId
		, BuildElement.id
		, BuildElement.spaceName
		, spaceType
		, subcontractType
		, isLocked =
			CASE WHEN BuildElementType.isEditable <> ProjectStatus.isEditable THEN 'True'
			ELSE 'False'
			END
		, buildCost =
		CASE
			WHEN spacePrice > 0 THEN
				spacePrice + (spacePrice*subcontractPercent/100)
			ELSE
				(SELECT isNull(SUM(buildCost),0) FROM @sum WHERE buildElementId = BuildElement.id) + 
				(SELECT
					isNull(Sum(
						CASE adhoctypeId
							WHEN 1 THEN TaskAddition.price
							WHEN 2 THEN (TaskAddition.price/100) * TaskAddition.percentage
							WHEN 3 THEN TaskAddition.price + (TaskAddition.price/100) * TaskAddition.percentage
						END
					), 0)
				FROM TaskAddition
				LEFT JOIN Task ON TaskAddition.taskId = Task.id
				LEFT JOIN BuildElement AS t_spaces ON Task.buildElementId = BuildElement.id
				WHERE projectId = @projectId AND spacePrice = 0 AND t_spaces.id = BuildElement.id
				)
			END
	FROM BuildElement
	LEFT JOIN Project ON BuildElement.projectId = Project.id
	LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	LEFT JOIN BuildElementSundryItem ON BuildElement.subcontractTypeId = BuildElementSundryItem.id
	WHERE 
		projectId = @projectId
		AND userId = @userId
	GROUP BY 
		projectId
		, BuildElement.id
		, spaceName
		, spaceType
		, subcontractType
		, spacePrice
		, subcontractPercent
		, BuildElementType.isEditable
		, ProjectStatus.isEditable
	ORDER BY BuildElement.spaceName

END
GO
