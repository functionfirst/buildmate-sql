USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[Build_Element_COMPLETION]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 27th September 2011
-- Description:	Retrieves total times for the build element
-- =============================================
CREATE PROCEDURE [dbo].[Build_Element_COMPLETION]
	-- Add the parameters for the stored procedure here
	@rid INT,
	@userID UNIQUEIDENTIFIEr
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @completion INT
	
	-- check for overriding percentage
	SELECT
		@completion = isNull(completion, 0)
	FROM tblSpaces
	LEFT JOIN tblProjects ON tblSpaces.projectid = tblProjects.id
	WHERE tblSpaces.id = @rid AND tblProjects.userID = @userID
	
	SELECT
		@completion = isNull(completion, 0)
	FROM tblSpaces
	LEFT JOIN tblProjects ON tblSpaces.projectid = tblProjects.id
	WHERE tblSpaces.id = @rid AND tblProjects.userID = @userID


	-- calculate percentage for child Tasks
	IF @completion = 0
		BEGIN
			-- Create temporary tables
			DECLARE @myTimes AS TABLE(
				totalTime INT,
				completedTime INT
			)
			
			INSERT INTO @myTimes(totaltime, completedTime)
			SELECT
				(tblTasks.qty * tblTaskData.minutes) AS totalTime
				, completedTime = (tblTasks.qty * tblTaskData.minutes) / 100 * tblTasks.percentComplete
			FROM tblTaskResources
			LEFT JOIN tblTasks ON tblTaskResources.taskId = tblTasks.id
			LEFT JOIN tblTaskData ON tblTasks.taskDataId = tblTaskData.id
			LEFT JOIN dbo.tblCatalogue ON tblTaskResources.catalogueId = dbo.tblCatalogue.id
			LEFT JOIN dbo.tblResources ON dbo.tblCatalogue.resourceId = dbo.tblResources.id
			LEFT JOIN dbo.tblSpaces ON tblTasks.roomId = dbo.tblSpaces.id
			LEFT JOIN dbo.tblProjects ON dbo.tblSpaces.projectId = dbo.tblProjects.id
			WHERE dbo.tblSpaces.id = @rid AND userId = @userId
			GROUP BY tblTasks.percentComplete, tblTasks.qty, tblTaskData.minutes, tblSpaces.completion

			SELECT
				totalTime = isNull(SUM(totalTime), 0)
				, completedTime = isNull(SUM(completedTime), 0)
				, remainingTime = isNull(SUM(totalTime) - SUM(completedTime), 0)
				, percentComplete = isNull(CAST(SUM(completedTime) AS decimal) / nullif(CAST(SUM(totalTime) AS DECIMAL(10,4)), 0) * 100, 0)
			FROM @myTimes
		END
	ELSE
		SELECT @completion AS percentComplete
	
	--completedTime = CASE
	--	WHEN tblSpaces.completion > 0 THEN (tblTasks.qty * tblTaskData.minutes) / 100 * tblSpaces.completion
	--	ELSE (tblTasks.qty * tblTaskData.minutes) / 100 * tblTasks.percentComplete
	--	END
END
GO
