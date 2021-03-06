USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskDetails]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 28th April 2008
-- Description:	Select Task adjustments for
--				the selected Task/Room.
-- =============================================
CREATE PROCEDURE [dbo].[getTaskDetails]
	-- Add the parameters for the stored procedure here
	@taskId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @taskname VARCHAR(255), @fullTaskName VARCHAR(800), @parentId INT

	-- construct the full task name
	SELECT @parentId = TaskData.parentId, @taskName = taskName
	FROM TaskData
	LEFT JOIN Task ON TaskData.id = Task.taskdataId
	WHERE Task.id = @taskId

	SET @fullTaskName = @taskName

	WHILE @parentId IS NOT NULL
	BEGIN
		SELECT @parentId = TaskData.parentID, @taskName = taskName
		FROM TaskData
		LEFT JOIN Task ON TaskData.id = Task.taskdataId
		WHERE TaskData.id = @parentId

		SET @fullTaskName = @taskName + '; ' + @fullTaskName
	END

	-- get first labour item
	-- we'll use that as the estimate time for labour
	DECLARE @labourTime FLOAT

	SELECT TOP 1 @labourTime = isNull(uses, 0)
	FROM TaskResource
	LEFT JOIN Task ON TaskResource.taskid = Task.id
	LEFT JOIN [Resource] on TaskResource.resourceId = [Resource].id
	WHERE Task.id = @taskId
		AND resourceTypeId = 1 -- only pick out a labour resource

	-- get task details
	SELECT
		Task.id
		, taskName = @fullTaskName
		, buildPhase
		, Task.buildPhaseId
		, Task.id
		, Task.qty
		, note
		, unit
		, isDefaultResource
		, [minutes]
		, projectStatusId
		, isLocked =
			CASE WHEN BuildElementType.isEditable <> ProjectStatus.isEditable THEN 'True'
			ELSE 'False'
			END
		, buildElementTypeId
		, CASE
			WHEN taskTime > 0 OR taskTime is not null THEN isNull(taskTime,0)
			ELSE isNull(Task.qty * @labourTime, 0)
		END
	AS totalTime,
	isNull(@labourTime, 0) AS labourTime
	FROM Task 
	LEFT JOIN TaskBuildPhase ON buildPhaseId = TaskBuildPhase.id
	LEFT JOIN TaskData ON Task.taskDataId = TaskData.id
	LEFT JOIN ResourceUnit ON ResourceUnit.id = TaskData.unitId
	LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	LEFT JOIN Project ON BuildElement.projectId = Project.id
	LEFT JOIN TaskResource ON Task.id = TaskResource.taskId
	LEFT JOIN BuildElementType on BuildElement.buildElementTypeId = BuildElementType.id
	LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
	WHERE Task.id = @taskId

END
GO
