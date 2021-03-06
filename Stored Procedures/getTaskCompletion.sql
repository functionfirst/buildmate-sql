USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskCompletion]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st October 2011
-- Description:	get the completion % for the Task
-- =============================================
CREATE PROCEDURE [dbo].[getTaskCompletion] 
	-- Add the parameters for the stored procedure here
	@taskId INT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Task.id, Task.percentComplete, actualMinutes
    FROM Task
    LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
    LEFT JOIN Project ON Project.id = BuildElement.projectId
    WHERE Task.id = @taskId AND Project.userID = @userId
END
GO
