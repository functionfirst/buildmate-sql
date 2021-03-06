USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getBuildElementCompletion]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st October 2011
-- Description:	get the completion % for the build element
-- =============================================
CREATE PROCEDURE [dbo].[getBuildElementCompletion]
	-- Add the parameters for the stored procedure here
	@roomId INT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT BuildElement.id, BuildElement.completion
    FROM BuildElement
    LEFT JOIN Project ON Project.id = BuildElement.projectId
    WHERE BuildElement.id = @roomId AND Project.userID = @userId
END
GO
