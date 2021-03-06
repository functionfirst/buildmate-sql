USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[PROJECT_select_template]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 7th January 2013
-- Description:	Select Templates either from Buildmate or using the Customers projects as templates
-- =============================================
CREATE PROCEDURE [dbo].[PROJECT_select_template]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@projectSource TINYINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @projectSource = 1
		BEGIN
			SELECT Project.id, projectName, projectTypeId
			FROM Project
			WHERE userID = @userId
			ORDER BY projectName
		END
	ELSE
	BEGIN
		SELECT Project.id, projectName, projectTypeId
		FROM Project
		WHERE Project.id IN (SELECT ProjectId FROM ProjectTemplate)
		ORDER BY projectName
	END
END
GO
