/****** Object:  Trigger [dbo].[deleteChildCatalogueUseage]    Script Date: 05/19/2014 00:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 20th November 2011
-- Description:	Delete catalogue useage records relating to this catalogue record
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'deleteChildCatalogueUseage')
	EXEC ('DROP TRIGGER dbo.deleteChildCatalogueUseage')
GO

CREATE TRIGGER [dbo].[deleteChildCatalogueUseage]
     ON  [dbo].[Catalogue]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- get the catalogueId of the deleted resource
	DECLARE @catalogueId INT
	SELECT @catalogueId = id FROM DELETED
	
	-- DELETE Catalogue records
	DELETE FROM CatalogueUseage WHERE catalogueId = @catalogueId
END
