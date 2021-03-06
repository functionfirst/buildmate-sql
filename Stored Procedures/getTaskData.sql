USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskData]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 18th December 2008
-- Description:	Select top level task data for a given room/space
-- =============================================
CREATE PROCEDURE [dbo].[getTaskData]
	-- Add the parameters for the stored procedure here
	@roomId INT,
	@parentId INT,
	@showall TINYINT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @showall IS NULL
    BEGIN
		SELECT Task.id AS taskId, TaskData.id, taskName, keywords
		FROM TaskData
		LEFT JOIN Task ON TaskData.id = Task.taskDataId
		WHERE hidden=0 AND TaskData.ParentId IS NULL AND Task.buildElementId = @roomId
		UNION
		SELECT taskId = 0, TaskData.id, taskName, keywords
		FROM TaskData
		WHERE hidden=0 AND TaskData.parentId IS NULL AND (
			id NOT IN (
				SELECT taskDataId
				FROM Task
				WHERE buildElementId = @roomId
			)
		)
	END
		SELECT Task.id AS taskId, TaskData.id, taskName, keywords
		FROM TaskData
		LEFT JOIN Task ON TaskData.id = Task.taskDataId
		WHERE TaskData.ParentId IS NULL AND Task.buildElementId = @roomId
		UNION
		SELECT taskId = 0, TaskData.id, taskName, keywords
		FROM TaskData
		WHERE hidden=0 AND TaskData.parentId IS NULL AND (
			id NOT IN (
				SELECT taskDataId
				FROM Task
				WHERE buildElementId = @roomId
			)
		)
	RETURN
END
GO
