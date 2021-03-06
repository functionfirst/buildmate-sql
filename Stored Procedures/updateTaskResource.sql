USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateTaskResource]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st December 2009
-- Description:	Update task resource
--				Also needs to resynchronise the stack for this resource.
-- =============================================
CREATE PROCEDURE [dbo].[updateTaskResource]
	@userId UNIQUEIDENTIFIER
	,@projectId INT
	, @uses FLOAT
	, @qty INT
	, @id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @resourceId INT

	-- Update the task resource with the new uses and qty
	UPDATE TaskResource SET uses=@uses, qty=@qty WHERE id = @id
	
	-- get isEditable from parent Build Element
	DECLARE @isEditable TINYINT
	SELECT @isEditable = isEditable
	FROM TaskResource
	LEFT JOIN Task ON TaskResource.taskId = Task.id
	LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	WHERE TaskResource.id= @id

	-- update resource stack
	Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
END
GO
