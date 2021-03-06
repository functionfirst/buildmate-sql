USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateBuildElementCompletion]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st October 2011
-- Description:	update the completion % for the build element
-- =============================================
CREATE PROCEDURE [dbo].[updateBuildElementCompletion]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@completion INT,
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    UPDATE BuildElement
    SET BuildElement.completion = @completion
    FROM BuildElement
    LEFT JOIN Project ON Project.id = BuildElement.projectId
    WHERE BuildElement.id = @id AND Project.userID = @userId
END
GO
