USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[Resources_INSERT]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 19th March 2011
-- Description:	Add new resource, catalogue and catalogue useage.
-- used in:
-- =============================================
CREATE PROCEDURE [dbo].[Resources_INSERT]
	-- Add the parameters for the stored procedure here
	@resourceName VARCHAR(255),
	@manufacturer VARCHAR(120),
	@supplierId INT,
	@partId VARCHAR(50),
	@resourceTypeId INT,
	@categoryId INT,
	@unitId INT,
	@suffix VARCHAR(50),
	@waste FLOAT,
	@keywords VARCHAR(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
	DECLARE @resourceid INT, @catalogueId INT

    -- Insert the resource
    INSERT INTO tblResources (resourceName, manufacturer, partId, resourceTypeId, categoryId, unitId, suffix, waste, keywords)
	VALUES(@resourceName, @manufacturer, @partId, @resourceTypeId, @categoryId, @unitId,@suffix, @waste, @keywords);
	SELECT @resourceId = SCOPE_IDENTITY(); 

	-- insert the supplier/resource
	INSERT INTO tblCatalogue(supplierId, resourceId) VALUES(@supplierId, @resourceId);
	SELECT @catalogueId = SCOPE_IDENTITY();
	
	-- insert catalogue useage
	
	
END
GO
