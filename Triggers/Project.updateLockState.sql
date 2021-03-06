USE [getbuild_mate]
GO
/****** Object:  Trigger [dbo].[updateLockState]    Script Date: 05/19/2014 00:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 22nd September 2011
-- Description:	Set lock state of child spaces and tasks
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'updateLockState')
	EXEC ('DROP TRIGGER dbo.updateLockState')
GO

CREATE TRIGGER [dbo].[updateLockState]
   ON  [dbo].[Project]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here	
	--DECLARE @isLocked BIT, @projectId INT
	
	--SELECT @isLocked = isLocked, @projectid = INSERTED.id
	--FROM INSERTED
	--LEFT JOIN ProjectStatus ON INSERTED.projectStatusId = ProjectStatus.id
	
	---- if islocked = 1
	---- update non-variation build elements and set them to 1
	---- update non-variation tasks and set them to 1
	---- update 

	---- update lock state of all non-variant build elements
	--UPDATE BuildElement SET isLocked = @isLocked
	--FROM BuildElement 
	--LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	--WHERE BuildElementType.isLocked = 1 AND BuildElement.projectId = @projectId
	
	---- update lock state of all Tasks in non-variant build elements
	--UPDATE Task SET isLocked = @isLocked
	--FROM Task
	--LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	--LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	--WHERE BuildElementType.isLocked = 1 AND BuildElement.projectId = @projectId
	
	---- update lock state of all Resource Stacks in this project
	--UPDATE TaskResourceStack SET isLocked = @isLocked
	--FROM TaskResource
	--LEFT JOIN TaskResourceStack ON TaskResource.resourceId = TaskResourceStack.resourceId
	--LEFT JOIN Task ON TaskResource.taskId = Task.id
	--LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	--LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	--WHERE BuildElementType.isLocked = 1 AND BuildElement.projectId = @projectId

	
	----UPDATE TaskResourceStack SET isLocked = @isLocked WHERE id IN(
	----	SELECT DISTINCT TaskResourceStack.id
	----	FROM TaskResource
	----	LEFT JOIN TaskResourceStack ON TaskResourceStack.resourceId = TaskResource.resourceId
	----	LEFT JOIN Task ON TaskResource.taskId = Task.id
	----	WHERE Task.isLocked = 1 AND TaskResourceStack.projectId = @projectId
	----)
END
