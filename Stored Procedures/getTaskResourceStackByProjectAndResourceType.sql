USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskResourceStackByProjectAndResourceType]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 7th November 2011
-- Description:	Get the resource stack for this project
-- =============================================
CREATE PROCEDURE [dbo].[getTaskResourceStackByProjectAndResourceType]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
	, @projectId INT
	, @resourceTypeId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		resourceId
		, resourceTypeId
		, resourceName
		, unit AS netUnit
		, qty*useage AS netQty
		, TaskResourceStack.suffix AS purchaseUnit
		, qty AS purchaseQty
		, price AS purchaseCost
		, qty * price AS projectCost
		, isNull(round((qty * price) * (waste/100), 2), 0) AS projectWaste
		, CASE incWaste 
				WHEN 0 THEN isNull(round((qty * price), 2), 0)
				WHEN 1 THEN isNull(round((qty * price) * (1+(waste/100)), 2), 0)
			END  AS projectTotalCost
		, TaskResourceStack.isLocked
		, TaskResourceStack.isEditable
		, incWaste
		, waste as wastePercent
	FROM TaskResourceStack
	LEFT JOIN [Resource] ON TaskResourceStack.resourceId = [Resource].id
	LEFT JOIN ResourceUnit ON [Resource].unitId = ResourceUnit.id
	LEFT JOIN Project ON TaskResourceStack.projectId = Project.id
	WHERE projectId = @projectId AND resourceTypeId = @resourceTypeId AND userID = @userId
	ORDER BY resourceName, useage DESC
END
GO
