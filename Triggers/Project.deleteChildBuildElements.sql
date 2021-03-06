/****** Object:  Trigger [dbo].[deleteChildBuildElements]    Script Date: 05/19/2014 00:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 20th November 2011
-- Description:	Delete anything related to this Project.
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'deleteChildBuildElements')
	EXEC ('DROP TRIGGER dbo.deleteChildBuildElements')	
GO

CREATE TRIGGER [dbo].[deleteChildBuildElements]  
   ON  [dbo].[Project]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- get the buildElement id of the deleted task
	DECLARE @projectId INT
	SELECT @projectId = id FROM DELETED

	-- DELETE project log
	DELETE ProjectLog WHERE projectId = @projectId

	-- DELETE build elements
	DELETE FROM BuildElement WHERE projectId = @projectId
	
	-- DELETE Resource Stack
	DELETE FROM TaskResourceStack WHERE projectId = @projectId
	
	-- DELETE template
	DELETE FROM ProjectTemplate WHERE projectId = @projectId
END
