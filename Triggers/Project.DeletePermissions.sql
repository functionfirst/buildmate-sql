USE [getbuild_mate]
GO
/****** Object:  Trigger [dbo].[DeletePermissions]    Script Date: 05/19/2014 00:49:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th January 2014
-- Description:	Delete user permissions for the Project
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'DeletePermissions')
	EXEC ('DROP TRIGGER dbo.DeletePermissions')	
GO

CREATE TRIGGER [dbo].[DeletePermissions]
   ON  [dbo].[Project] 
   AFTER DELETE
AS 
BEGIN
	
	DECLARE @userId UNIQUEIDENTIFIER, @id INT
	SELECT @userId = userId, @id = id FROM DELETED
	
	DELETE FROM Permission WHERE aggregationId = 1 AND userId = @userId AND objectId = @id
END
