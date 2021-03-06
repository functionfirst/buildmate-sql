/****** Object:  Trigger [dbo].[deleteChildCatalogue]    Script Date: 05/19/2014 00:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 20th November 2011
-- Description:	Delete catalogue records relating to this Resource
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'deleteChildCatalogue')
	EXEC ('DROP TRIGGER dbo.deleteChildCatalogue')
GO

CREATE TRIGGER [dbo].[deleteChildCatalogue]
   ON  [dbo].[Resource]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- get the resourceId of the deleted resource
	DECLARE @resourceId INT
	SELECT @resourceId = id FROM DELETED
	
	-- DELETE Catalogue records
	DELETE FROM Catalogue WHERE resourceId = @resourceId
END
