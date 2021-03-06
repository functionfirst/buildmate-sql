USE [getbuild_mate]
GO
/****** Object:  Trigger [dbo].[RemovePermissions]    Script Date: 05/19/2014 00:50:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 6th January 2014
-- Description:	Delete user permissions when the Project is deleted
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'RemovePermissions')
	EXEC ('DROP TRIGGER dbo.RemovePermissions')
GO

CREATE TRIGGER [dbo].[RemovePermissions]
   ON  [dbo].[Project]
   AFTER DELETE
AS 
BEGIN
    -- Insert statements for trigger here
	DELETE FROM Permission WHERE aggregationId = 1 AND objectId IN (
		SELECT id FROM deleted
	)
END
