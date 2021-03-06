USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectCompletionPercentage]    Script Date: 01/08/2014 21:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th September 2011
-- Description:	Retrieves total times for the project
-- =============================================
CREATE PROCEDURE [dbo].[getProjectCompletionPercentage]
	-- Add the parameters for the stored procedure here
	@pid BIGINT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Create temporary tables
	DECLARE @myTimes AS TABLE(
		totalTime INT,
		completedTime INT
	)
	
	INSERT INTO @myTimes(totaltime, completedTime)
	SELECT
		(Task.qty * TaskData.minutes) AS totalTime
		, completedTime = CASE
		WHEN BuildElement.completion > 0 THEN (Task.qty * TaskData.minutes) / 100 * BuildElement.completion
		ELSE (Task.qty * TaskData.minutes) / 100 * Task.percentComplete
		END
		
	FROM TaskResource
	LEFT JOIN Task ON TaskResource.taskId = Task.id
	LEFT JOIN TaskData ON Task.taskDataId = TaskData.id
	LEFT JOIN [Resource] ON TaskResource.resourceId = [Resource].id
	LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	LEFT JOIN Project ON BuildElement.projectId = Project.id
	WHERE Project.id = @pid AND userId = @userId
	GROUP BY Task.percentComplete, Task.qty, TaskData.minutes, BuildElement.completion

	SELECT
		totalTime = isNull(SUM(totalTime), 0)
		, completedTime = isNull(SUM(completedTime), 0)
		, remainingTime = isNull(SUM(totalTime) - SUM(completedTime), 0)
		, percentComplete = isNull(CAST(SUM(completedTime) AS decimal) / nullif(CAST(SUM(totalTime) AS DECIMAL(10,4)), 0) * 100, 0)
	FROM @myTimes
END
GO
