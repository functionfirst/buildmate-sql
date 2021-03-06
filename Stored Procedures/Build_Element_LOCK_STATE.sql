USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[Build_Element_LOCK_STATE]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 15th September 2011
-- Description:	Check lockstate of the current project.
-- =============================================
CREATE PROCEDURE [dbo].[Build_Element_LOCK_STATE]
	-- Add the parameters for the stored procedure here
	@roomId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Check for lockstate of the current project   
	SELECT tblProjects.id
	FROM tblProjects
	LEFT JOIN tblSpaces ON tblSpaces.projectId = tblProjects.id
	LEFT JOIN tblSpaceTypes ON tblSpaces.spaceTypeId = tblSpaceTypes.id
	LEFT JOIN tblStatus ON tblProjects.statusID = tblStatus.id
	WHERE tblStatus.isLocked > tblSpaceTypes.isLocked AND tblSpaces.id = @roomId
END
GO
