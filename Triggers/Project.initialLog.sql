/****** Object:  Trigger [dbo].[initialLog]    Script Date: 05/19/2014 00:49:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th September 2011
-- Description:	Log initial project creation
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'initialLog')
	EXEC ('DROP TRIGGER dbo.initialLog')
GO

CREATE TRIGGER [dbo].[initialLog] 
   ON  [dbo].[Project]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- get projectid and userid from inserted
	DECLARE @userID UNIQUEIDENTIFIER, @projectId INT
	
	-- Insert statements for trigger here
	INSERT INTO ProjectLog(projectId, userid, statusId, note)
	SELECT id, created_by, projectStatusId, 'Project created' FROM INSERTED
	
END
