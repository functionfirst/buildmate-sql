USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getResourceDetails]    Script Date: 01/08/2014 21:36:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 15th November 2011
-- Description:	Get the Resource details
-- =============================================
CREATE PROCEDURE [dbo].[getResourceDetails]
	-- Add the parameters for the stored procedure here
	@resourceId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM Resource
    LEFT JOIN ResourceType ON Resource.resourceTypeId = ResourceType.id
    LEFT JOIN ResourceCategory ON Resource.categoryId = ResourceCategory.id
    LEFT JOIN ResourceUnit ON Resource.unitId = ResourceUnit.id
    WHERE Resource.id = @resourceId
END
GO
