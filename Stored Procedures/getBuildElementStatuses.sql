USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getBuildElementStatuses]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st October 2011
-- Description:	Grabs the status options for this Build Element
-- =============================================
CREATE PROCEDURE [dbo].[getBuildElementStatuses]
	-- Add the parameters for the stored procedure here
	@roomId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT id AS buildElementTypeId, spaceType FROM BuildElementType WHERE isLocked IN (
	--	SELECT isLocked =
	--		CASE WHEN BuildElementType.isEditable <>  ProjectStatus.isEditable THEN 'True'
	--		ELSE 'False'
	--		END
	--	FROM BuildElement
	--	LEFT JOIN Project ON BuildElement.projectid = Project.id
	--	LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
	--	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	--	WHERE BuildElement.id = @roomId
	--)
	--ORDER BY spaceType
	
	SELECT BuildElementType.id  AS buildElementTypeId, spaceType FROM BuildElementType WHERE isEditable IN(
		SELECT ProjectStatus.isEditable
		FROM BuildElement
		LEFT JOIN Project ON BuildElement.projectId = Project.id
		LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
		WHERE BuildElement.id = @roomId
	)
	ORDER BY spaceType
END
GO
