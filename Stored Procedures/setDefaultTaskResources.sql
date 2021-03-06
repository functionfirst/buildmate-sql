USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[setDefaultTaskResources]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 12th February 2012
-- Description:	Set the resources in this Task as the default settings.
-- =============================================
CREATE PROCEDURE [dbo].[setDefaultTaskResources]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@taskId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TaskDataId INT
	
	-- 1. this looked wrong, using 2. below instead.
	--	SELECT @taskDataId = taskDataId
	--	FROM BuildElement
	--	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	--	LEFT JOIN Task ON Task.buildElementId = BuildElement.id
	--	WHERE Task.id= @taskId
	
	-- 2. did this instead...
	-- Get the TaskData Id for this task
	SELECT @taskDataId = taskDataId
	FROM Task
	WHERE id= @taskId

    -- switch off isDefaultResource for other matching Tasks for this User
	UPDATE Task SET isDefaultResource = 0 WHERE id IN (	
		SELECT Task.id
		FROM Task
		LEFT JOIN BuildElement ON BuildElement.id = Task.buildElementId
		LEFT JOIN Project ON Project.id = BuildElement.projectId
		WHERE taskDataId = @TaskDataId AND userId = @userId
	)

	-- update task values
	UPDATE Task SET isDefaultResource = 1 WHERE id = @taskId

	-- check if there is an existing set of resources in the master list of TaskDataResources
	-- if not, add these as the master set
	IF NOT EXISTS(SELECT id FROM TaskDataResource WHERE taskDataId = @taskDataId)
	BEGIN
		-- stash these resources back to the master table
		INSERT INTO TaskDataResource(taskDataId, resourceId, uses, qty)
		SELECT @TaskDataId, resourceId, uses, qty
		FROM TaskResource
		WHERE taskId = @taskId
	END
END
GO
