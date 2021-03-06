/****** Object:  Trigger [dbo].[deleteChildTaskAdditions]    Script Date: 05/19/2014 00:48:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th January 2014
-- Description:	Delete any Task Additions related to these Tasks
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'deleteChildTaskAdditions')
	EXEC ('DROP TRIGGER dbo.deleteChildTaskAdditions')
GO

CREATE TRIGGER [dbo].[deleteChildTaskAdditions]
   ON  [dbo].[Task]
   AFTER DELETE
AS 
BEGIN
	-- DELETE task additions
	DELETE FROM taskAddition WHERE taskId IN (SELECT id FROM DELETED)
END
