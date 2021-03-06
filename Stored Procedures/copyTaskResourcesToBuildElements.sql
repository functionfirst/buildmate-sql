USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[copyTaskResourcesToBuildElements]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 26th September 2011
-- Description:	Copy all data from the selected Space
-- =============================================
CREATE PROCEDURE [dbo].[copyTaskResourcesToBuildElements] 
	-- Add the parameters for the stored procedure here
	@RoomId BIGINT,
	@NewRoomId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @id char(11), @newTaskId char(11)

	-- get first record pointer
	SELECT @id = MIN(id) FROM Task WHERE buildElementId = @roomId

	WHILE @id is not null
	BEGIN
		-- copy and insert new Task
		INSERT INTO Task (taskDataId, buildElementId, buildPhaseId, taskTime, qty, actualMinutes, percentComplete, note)
		SELECT taskDataId, @NewRoomId, buildPhaseId, taskTime, qty, actualMinutes, 0, note
		FROM Task WHERE id = @id
		SET @NewTaskId = SCOPE_IDENTITY();
		
		-- Copy ad-hoc additions
		INSERT INTO TaskAddition(taskId, [description], price, percentage, adhocTypeId)
		SELECT @NewtaskId, [description], price, percentage, adhocTypeId
		FROM TaskAddition WHERE taskId = @id
		
		-- copy and insert ressources for the new task
		INSERT INTO TaskResource(taskId, resourceId, uses, qty)
		SELECT @NewTaskId, resourceId, uses, TaskResource.qty
		FROM TaskResource
		LEFT JOIN Task ON TaskResource.taskId = Task.id
		WHERE Task.id = @id
		
		-- move to next record
		SELECT @id = MIN(id) FROM Task WHERE buildElementId = @roomId AND Task.id > @id 
	END
END
GO
