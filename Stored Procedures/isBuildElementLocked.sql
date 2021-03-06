USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[isBuildElementLocked]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 27th September 2011
-- Description:	Check lockstate of the current build element.
-- =============================================
CREATE PROCEDURE [dbo].[isBuildElementLocked]
	-- Add the parameters for the stored procedure here
	@roomId INT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT BuildElement.isLocked
	FROM BuildElement
	LEFT JOIN Project ON BuildElement.projectid = Project.id
	WHERE BuildElement.id = @roomid AND userId = @userId
END
GO
