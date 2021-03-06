USE [getbuild_mate]
GO
/****** Object:  Trigger [dbo].[AddPermissions]    Script Date: 05/19/2014 00:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 6th January 2014
-- Description:	Add user permissions for the Project
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AddPermissions')
	EXEC ('DROP TRIGGER dbo.AddPermissions')
GO

CREATE TRIGGER [dbo].[AddPermissions]
   ON  [dbo].[Project]
   AFTER INSERT
AS 
BEGIN
	INSERT INTO Permission(userId, aggregationId, objectId)
	SELECT userId, 1, id FROM inserted
END
