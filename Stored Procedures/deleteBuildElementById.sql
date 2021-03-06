USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[deleteBuildElementById]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Delete the selected build element
-- =============================================
CREATE PROCEDURE [dbo].[deleteBuildElementById]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
	, @projectId INT
	, @original_id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- get isEditable from parent Build Element
	DECLARE @isEditable TINYINT
	SELECT @isEditable = isEditable
	FROM BuildElement
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	WHERE BuildElement.id= @original_id
	
	-- DELETE Task additions
	DELETE FROM TaskAddition WHERE id IN (
		SELECT TaskAddition.id
		FROM TaskAddition
		LEFT JOIN Task ON Task.id = TaskAddition.taskId
		WHERE buildElementId = @original_id
	)
	
	-- DELETE Task Resources
	DELETE FROM TaskResource WHERE id IN(
		SELECT TaskResource.id
		FROM TaskResource
		LEFT JOIN Task ON Task.id = TaskResource.taskId
		WHERE buildElementId = @original_id
	)
	
	-- DELETE Tasks
	DELETE FROM Task WHERE buildElementId = @original_id

	-- DELETE the build element
    DELETE FROM BuildElement WHERE id = @original_id
    
	-- Update resource stack
	Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
    
END
GO
