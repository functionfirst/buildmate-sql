USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getBuildElementTypesByProject]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 15th May 2008
-- Description:	Grabs everything from tblSpaceTypes
-- =============================================
CREATE PROCEDURE [dbo].[getBuildElementTypesByProject]
	-- Add the parameters for the stored procedure here
	--@isLocked BIT
	@projectId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 --   -- Check project status ID and lock >= Submitted (7)
	--DECLARE @isLocked BIT
	--SET @isLocked = 0
	--If Exists(SELECT isLocked = 'True' FROM Project WHERE id = @projectId AND projectstatusId >= 3)
	--BEGIN
	--	SET @isLocked = 1
	--END

	---- GET space types depending on the lock state of the statusId of this project
	--SELECT id AS buildElementTypeId, isLocked, spaceType
	--FROM BuildElementType 
	--WHERE isLocked = @isLocked
	--ORDER BY spaceType
	
	SELECT BuildElementType.id  AS buildElementTypeId, spaceType FROM BuildElementType WHERE isEditable IN(
		SELECT ProjectStatus.isEditable
		FROM Project
		LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
		WHERE Project.id = @projectId
	)
	ORDER BY spaceType
END
GO
