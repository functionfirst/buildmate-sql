USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[isTaskLocked]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 28th September 2011
-- Description:	Check lockstate of the current task.
-- =============================================
CREATE PROCEDURE [dbo].[isTaskLocked] 
	-- Add the parameters for the stored procedure here
	@taskId INT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT BuildElement.isLocked
	FROM Task
	LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	LEFT JOIN Project ON BuildElement.projectid = Project.id
	WHERE Task.id = @taskId AND userID = @userId
END
GO
