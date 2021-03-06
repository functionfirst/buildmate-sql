USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[TaskResources_UPDATE_PRICES]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 21st August 2008
-- Description:	Refresh prices for Task Resources from Catalogue
-- =============================================
CREATE PROCEDURE [dbo].[TaskResources_UPDATE_PRICES]
	-- Add the parameters for the stored procedure here
	@projectId BIGINT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @catalogueId BIGINT, @taskResourceId BIGINT, @price MONEY

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 --   -- Check for existing local cursor
	--IF Cursor_Status('local', 'TaskResourceCursor' ) >= 0
	--BEGIN
	--	close TaskResourceCursor
	--	deallocate TaskResourceCursor
	--END

	---- Declare the cursor and recordset
	---- Grab Catalogue data that matches the Task Resources catalogueID
	--DECLARE TaskResourceCursor CURSOR LOCAL FOR
	--SELECT dbo.tblTaskResources.id, catalogueId
	--FROM dbo.tblTaskResources
	--LEFT JOIN dbo.tblTasks ON dbo.tblTasks.id = dbo.tblTaskResources.taskId
	--LEFT JOIN tblSpaces ON tblTasks.roomId = tblSpaces.id
	--LEFT JOIN tblProjects ON tblSpaces.projectId = tblProjects.id
	--WHERE tblProjects.id = @projectId AND userId = @userId

	--OPEN TaskResourceCursor

	---- Perform the first FETCH and store values in variables
	--FETCH NEXT FROM TaskResourceCursor INTO @taskResourceId, @catalogueId

	---- check @@FETCH_STATUS to see if there are any more rows to fetch
	--WHILE @@FETCH_STATUS = 0
	--BEGIN

	--	-- Get the price for the selected catalogue record (catalogueId)
	--	SELECT @price = price FROM tblCatalogueUseage WHERE catalogueId = @CatalogueId

	--	-- update task resource price
	--	UPDATE dbo.tblTaskResources SET price = @price WHERE id = @taskResourceId

	--	-- this is executed as long as the previous fetch succeeds
	--	FETCH NEXT FROM TaskResourceCursor INTO @taskResourceId, @catalogueId
	--END

	--CLOSE TaskResourceCursor
	--DEALLOCATE TaskResourceCursor
END
GO
