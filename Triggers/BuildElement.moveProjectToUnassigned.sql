/****** Object:  Trigger [dbo].[moveProjectToUnassigned]    Script Date: 05/19/2014 00:42:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th July 2012
-- Description:	Move project status to unassigned if all build elements are deleted
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'moveProjectToUnassigned')
	EXEC ('DROP TRIGGER dbo.moveProjectToUnassigned')
GO

CREATE TRIGGER [dbo].[moveProjectToUnassigned] 
   ON [dbo].[BuildElement]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- get project id
    DECLARE @pid INT, @userId UNIQUEIDENTIFIER
    
	SELECT @pid = projectId, @userId = userId
	FROM DELETED
	LEFT JOIN Project ON DELETED.projectid = Project.id
	
	-- check if project has child build elements
	IF NOT EXISTS(SELECT top 1 * FROM BuildElement WHERE projectId = @pid)
	BEGIN
		UPDATE Project SET projectStatusId = 1 WHERE id = @pid
		
		-- project log message
		INSERT INTO ProjectLog (userId, projectId, note) VALUES(@userId, @pid, 'Automatically changed status to Unassigned as all Build Elements were removed).')
	END
END
