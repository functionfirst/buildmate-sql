USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[PROJECT_RESOURCES]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 8th May 2011
-- Description:	Retrieves data for resource costs within the selected project
-- material_costs.aspx
-- labour_costs.aspx	
-- plant_costs.aspx

-- =============================================
CREATE PROCEDURE [dbo].[PROJECT_RESOURCES]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@projectId BIGINT,
	@resourceTypeId INT,
	@grandTotalOnly BIT = 0,
	@grandTotalValue MONEY OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		resourceid
		, resourceName
		, supplierName
		, unit
		, useage
		, suffix
		, price
		, qty
	, round((price * qty),2) AS cost
	, round(((price * qty)*waste),2) AS wasteCost
	, round((price * qty) + ((price * qty)*waste),2) AS totalCost
	FROM v_project_resources
	WHERE projectId = @projectId
	AND userId = @userId
	AND resourceTypeId = @resourceTypeId 
	GROUP BY supplierId, resourceid, resourceName, supplierName, Unit, useage, suffix, price, qty, waste
END
GO
