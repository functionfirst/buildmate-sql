USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[report_RESOURCES]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 29th August 2011
-- Description:	Report of resources by supplier
-- =============================================
CREATE PROCEDURE [dbo].[report_RESOURCES] 
	-- Add the parameters for the stored procedure here
	@pid INT
	, @resourceTypeId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		userId
		, projectId
		, qty
		, (price*qty)*(1+(waste/100)) AS price
		, suffix
		, dbo.HtmlEncode(resourceName) AS resourceName
		, resourceTypeId
		, dbo.HtmlEncode(supplierName) AS supplierName
		, lastUpdated
		, dbo.HtmlEncode(productCode) AS productCode
		, dbo.HtmlEncode(manufacturer) AS manufacturer
		, partId
	FROM view_RESOURCES
	WHERE projectId = @pid AND resourceTypeId = @resourceTypeId
END
GO
