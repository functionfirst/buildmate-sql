USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskDataFullName]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st February 2011
-- Description:	Get the concatenated task name
-- =============================================
CREATE PROCEDURE [dbo].[getTaskDataFullName]
	-- Add the parameters for the stored procedure here
	@taskId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @taskname VARCHAR(255), @fullTaskName VARCHAR(800), @parentId INT, @pid INT

	SELECT @parentId = parentId, @taskName = taskName
	FROM TaskData
	WHERE id = @taskId

	SET @pid = @parentId
	
	SET @fullTaskName = @taskName

	WHILE @parentId IS NOT NULL
	BEGIN
		SELECT @parentId = parentId, @taskName = taskName
		FROM TaskData
		WHERE id = @parentId

		SET @fullTaskName = @taskName + '; ' + @fullTaskName
	END
	
	Select parentid = @pid, taskName = @fullTaskName
END
GO
