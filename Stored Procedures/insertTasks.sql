USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertTasks]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 22nd April 2008
-- Description:	Inserts a new Task and if necessary cascades
--              to insert the Group and Project Tasks above.
-- =============================================
CREATE PROCEDURE [dbo].[insertTasks]
	-- Add the parameters for the stored procedure here
	@taskDataId INT,
	@roomId INT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--DECLARE @parentId INT, @tempId INT, @id INT, @taskId INT, @buildPhaseId INT
	DECLARE @taskId INT
	
	-- check the task doesn't already exist.
	IF NOT EXISTS(SELECT id FROM Task WHERE buildElementId = @roomId AND taskDataId = @taskDataId)
	BEGIN
		-- insert the new task data
		INSERT INTO Task(taskDataId, buildElementId, buildPhaseId, qty, percentComplete)
		SELECT @taskDataId, @roomId, isNull(buildPhaseId, 1), 0, 0
		FROM TaskData
		WHERE TaskData.id = @taskDataId;
		SELECT @taskId = @@Identity
		
		-- USER: identify the Task to copy default resources from for this user
		DECLARE @copyFromTaskId INT
		SET @copyFromTaskId = 0
		
		SELECT @copyFromTaskId = Task.id
		FROM Task
		LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
		LEFT JOIN Project ON BuildElement.projectId = Project.id
		WHERE Task.isDefaultResource = 1 AND TaskDataId = @taskDataId AND userId = @userId
		
		IF @copyFromTaskId > 0
			-- this user has default resources for this task 
			BEGIN
				INSERT INTO TaskResource(taskId, resourceId, uses, qty)
				SELECT taskId = @taskId, resourceId, uses, qty
				FROM TaskResource WHERE taskId = @copyFromTaskId
			END
		ELSE
			-- GLOBAL: NO user resources were found so check for default global resources to add to this task
			IF EXISTS(SELECT id FROM TaskDataResource WHERE taskDataId = @taskDataId)
			BEGIN
				INSERT INTO TaskResource(taskId, resourceId, uses, qty)
				SELECT taskId = @taskId, resourceId, uses, qty
				FROM TaskDataResource
				WHERE taskDataId = @taskDataId
			END
	END
	
	
END
GO
