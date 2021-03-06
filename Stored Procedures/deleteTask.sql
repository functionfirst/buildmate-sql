USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[deleteTask]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
--- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Delete task
-- =============================================
CREATE PROCEDURE [dbo].[deleteTask]
	-- Add the parameters for the stored procedure here
	@id INT
	, @userId UNIQUEIDENTIFIER
	, @projectId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- get task info
	DECLARE @taskId INT, @isLocked BIT
	SELECT @taskId = id, @isLocked = isLocked FROM Task WHERE id = @id

	-- get isEditable from parent Build Element
	DECLARE @isEditable TINYINT
	SELECT @isEditable = isEditable
	FROM BuildElement
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	LEFT JOIN Task ON Task.buildElementId = BuildElement.id
	WHERE Task.id= @id

	-- delete the task
	DELETE FROM Task WHERE id = @id
	
	-- update resource stack
	Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
END
GO
