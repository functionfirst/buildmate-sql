USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[copyBuildElementsToProject]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 26th September 2011
-- Description:	Copy all data for the projectID specified
-- =============================================
CREATE PROCEDURE [dbo].[copyBuildElementsToProject]
	-- Add the parameters for the stored procedure here
	@UserId UNIQUEIDENTIFIER,
	@ProjectId BIGINT,
	@NewProjectId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @RoomId char(11), @NewRoomId char(11)
	
	-- get first record pointer
	SELECT @RoomId = MIN(id) FROM BuildElement WHERE projectId = @ProjectId AND buildElementTypeId NOT IN(7)

	WHILE @RoomId is not null
	BEGIN
		-- copy and insert new build element
		INSERT INTO BuildElement (projectId, buildElementTypeId, spaceName, subcontractTypeId, subcontractPercent, spacePrice, completion)
		SELECT @NewProjectId, buildElementTypeId, spaceName, subcontractTypeId, subcontractPercent, spacePrice, 0
		FROM BuildElement WHERE id = @RoomId
		SET @NewRoomId = SCOPE_IDENTITY();

		---- copy and insert tasks/resources for the new space
		EXEC copyTaskResourcesToBuildElements @RoomId, @NewRoomId;
		
		-- move to next record
		SELECT @RoomId = MIN(id) FROM BuildElement WHERE projectId = @ProjectId AND buildElementTypeId NOT IN(7) AND BuildElement.id > @RoomId
	END
	
	-- Populate the Task Resource Stack	
	-- by running the resource stack for this project
	-- PARAM: userid, projectid, resourceid, isEditable
	Exec dbo.modifyResourceStack @userId, @NewProjectId, NULL, 0
END
GO
