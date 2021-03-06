USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateTaskCompletion]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st October 2011
-- Description:	update the completion % for the Task
-- =============================================
CREATE PROCEDURE [dbo].[updateTaskCompletion]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@percentComplete INT,
	@actualMinutes INT,
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Task
    SET Task.percentComplete = @percentComplete, actualMinutes = @actualMinutes
    FROM Task
    LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
    LEFT JOIN Project ON Project.id = BuildElement.projectId
    WHERE Task.id = @id AND Project.userID = @userId
END
GO
