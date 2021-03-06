USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[swapTaskResource]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 4th December 2011
-- Description:	Swaps the original resource with a new resource
-- =============================================
CREATE PROCEDURE [dbo].[swapTaskResource]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
	, @projectId INT
	, @oldResourceId INT
	, @resourceId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE TaskResource SET resourceId = @resourceId
	WHERE TaskResource.id IN(
		SELECT TaskResource.id
		FROM TaskResource
		LEFT JOIN Task ON TaskResource.taskId = Task.id
		LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
		WHERE projectId = @projectId AND TaskResource.resourceId = @oldResourceId
	)
	
	-- get the current editable state of the project
	DECLARE @isEditable INT
	SELECT @isEditable = isEditable
	FROM Project LEFT JOIN ProjectStatus ON projectstatus.id = Project.projectStatusId
	WHERE project.id = @projectId
	
	-- update resource stack
	Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
END
GO
