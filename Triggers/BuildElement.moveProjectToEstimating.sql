/****** Object:  Trigger [dbo].[moveProjectToEstimating]    Script Date: 05/19/2014 00:42:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th July 2012
-- Description:	Move project status to estimating if currently unassigned and a build element is created.
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'moveProjectToEstimating')
	EXEC ('DROP TRIGGER dbo.moveProjectToEstimating')
GO

CREATE TRIGGER [dbo].[moveProjectToEstimating] 
   ON [dbo].[BuildElement]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- get project id and status
    DECLARE @pid INT, @statusId INT, @userId UNIQUEIDENTIFIER
	
	SELECT @pid = projectId, @statusId = projectStatusId, @userId = userId
	FROM INSERTED
	LEFT JOIN Project ON INSERTED.projectid = Project.id
	
	-- check if project is in unassigned stage
	IF(@statusId = 1)
	BEGIN
		UPDATE Project SET projectStatusId = 2 WHERE id = @pid
		
		-- project log message
		INSERT INTO ProjectLog (userId, projectId, note) VALUES(@userId, @pid, 'Automatically changed status to Estimating as a new Build Element was added).')
	END
END
