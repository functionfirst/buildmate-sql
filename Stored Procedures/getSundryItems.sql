USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSundryItems]    Script Date: 01/08/2014 21:36:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 11th August 2011
-- Description:	Retrieve a list of sundry items for the current project
-- =============================================
CREATE PROCEDURE [dbo].[getSundryItems]
	-- Add the parameters for the stored procedure here
	@projectId INT,
	@userID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT BuildElement.id, projectId, spaceName AS buildElementName, spaceType AS buildElementType, subcontractType, spacePrice+(spacePrice*subContractPercent/100) AS spacePrice
	FROM BuildElement, BuildElementType, BuildElementSundryItem, Project
	WHERE
		BuildElement.buildelementTypeId = BuildElementType.id
		AND BuildElement.subcontractTypeId = BuildElementSundryItem.id
		AND BuildElement.projectId = Project.id
		AND userId = @userId AND projectId = @projectId AND spacePrice > 0
	ORDER BY buildElementName
END
GO
