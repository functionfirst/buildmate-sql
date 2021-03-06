USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getCurrentTaskDataByBuildElement]    Script Date: 01/08/2014 21:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 8th April 2009
-- Description:	Gets all current Task data for the selected room/space
-- =============================================
CREATE PROCEDURE [dbo].[getCurrentTaskDataByBuildElement]
	-- Add the parameters for the stored procedure here
	@roomId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- get project id
    DECLARE @projectId BIGINT
    SELECT @projectId = projectId FROM BuildElement where id = @roomId
	
	DECLARE @taskname VARCHAR(255), @fullTaskName VARCHAR(800), @parentId INT;

	DECLARE @taskDataId INT

	;WITH Tasks_CTE (projectId, roomId, taskId, parentId, taskName, qty) AS
	(
		SELECT projectId = @projectId, roomId = @roomId, Task.id AS taskId, TaskData.parentId, CAST(MIN(taskName) AS VARCHAR(8000)), Task.qty
		FROM Task
		LEFT JOIN TaskData ON Task.taskDataId = TaskData.id
		WHERE Task.buildElementId = @roomId
		GROUP BY TaskData.id, TaskData.parentId, Task.qty, Task.id
		UNION ALL
		SELECT projectId = @projectId, roomId = @roomId, CT.taskId, TD.parentId, TD.taskName + '; ' + CT.taskName, CT.qty
		FROM TaskData AS TD
		INNER JOIN Tasks_CTE AS CT ON CT.parentId = TD.id
		WHERE TD.parentId IS NOT NULL
	)
	
	SELECT taskId AS id, projectId as pid, roomId AS rid, TaskData.taskName AS groupName, Tasks_CTE.taskName, qty
	FROM Tasks_CTE
	LEFT JOIN TaskData ON TaskData.id = Tasks_CTE.parentId
	WHERE  TaskData.parentId IS NULL
	ORDER BY groupName, taskName
END
GO
