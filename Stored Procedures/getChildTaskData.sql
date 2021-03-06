USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getChildTaskData]    Script Date: 01/08/2014 21:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 24th April 2008
-- Description:	Select Tasks and and child data matching the selected parent task
-- =============================================
CREATE PROCEDURE [dbo].[getChildTaskData]
	-- Add the parameters for the stored procedure here
	@roomId INT,
	@parentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		Task.id AS taskId, TaskData.id, TaskData.taskName,
		TaskData.keywords, count(children.id) AS HasChildren,
		TaskData.minutes, qty
	FROM TaskData
	RIGHT JOIN Task ON TaskData.id = Task.taskDataId
	LEFT JOIN TaskData AS children ON TaskData.id = children.parentId
	WHERE TaskData.ParentId = @parentId AND Task.buildElementId = @roomId AND TaskData.hidden=0 -- AND children.hidden=0
	GROUP BY
		TaskData.id, TaskData.taskName,
		Task.id, TaskData.minutes, qty, TaskData.keywords
	UNION

	SELECT
		taskId = 0
		, TaskData.Id
		, TaskData.taskName
		, TaskData.keywords
		, COUNT(Children.Id) AS HasChildren
		, minutes=0
		, qty = 0
	FROM TaskData
	LEFT JOIN TaskData Children ON TaskData.Id = Children.ParentId
	WHERE TaskData.ParentId = @parentId AND TaskData.hidden=0 AND TaskData.id NOT IN
		(
			SELECT taskDataId FROM Task WHERE buildElementId = @roomId
		)
	GROUP BY TaskData.Id, TaskData.taskName, TaskData.keywords
	ORDER BY HasChildren DESC, TaskData.id

	RETURN
END
GO
