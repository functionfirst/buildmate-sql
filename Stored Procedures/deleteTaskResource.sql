USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[deleteTaskResource]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 11th August 2011
-- Description:	Delete the specified resource from this task.
-- =============================================
CREATE PROCEDURE [dbo].[deleteTaskResource]
	-- Add the parameters for the stored procedure here
	@id INT
	, @projectId INT
	, @userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @taskId INT, @isLocked BIT, @isEditable TINYINT

	-- get TaskResourceStack details before Resource is deleted
	--SELECT @taskId = taskId, @isLocked = isLocked
	--FROM TaskResource
	--LEFT JOIN Task ON TaskResource.taskId = Task.id
	--WHERE TaskResource.id = @id	

	-- get isEditable from parent Build Element
	SELECT @isEditable = isEditable
	FROM TaskResource
	LEFT JOIN Task ON TaskResource.taskId = Task.id
	LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	WHERE TaskResource.id= @id

	-- Delete the TaskResource
	DELETE FROM TaskResource WHERE id = @Id
	
	-- Update the resource stack after the delete
	Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
END
GO
