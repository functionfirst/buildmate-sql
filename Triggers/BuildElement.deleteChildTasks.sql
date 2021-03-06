/****** Object:  Trigger [dbo].[deleteChildTasks]    Script Date: 05/19/2014 00:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th January 2014
-- Description:	Delete any Tasks related to these Build Elements
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'deleteChildTasks')
	EXEC ('DROP TRIGGER dbo.deleteChildTasks')
GO

CREATE TRIGGER [dbo].[deleteChildTasks]
   ON  [dbo].[BuildElement]
   AFTER DELETE
AS 
BEGIN
	-- DELETE tasks
	DELETE FROM Task WHERE buildElementId IN (SELECT id FROM DELETED)
END
