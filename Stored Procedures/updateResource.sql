USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateResource]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 15th November 2011
-- Description:	Update the Resource
-- =============================================
CREATE PROCEDURE [dbo].[updateResource] 
	-- Add the parameters for the stored procedure here
	@resourceName VARCHAR(255),
	@manufacturer VARCHAR(120),
	@partId VARCHAR(50),
	@resourceTypeId INT,
	@categoryId INT, 
	@unitId INT,
	@waste FLOAT,
	@keywords VARCHAR(255),
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE Resource SET
		resourceName = @resourceName,
		manufacturer = @manufacturer,
		partId = @partId,
		resourceTypeId = @resourceTypeId,
		categoryId = @categoryId, 
		unitId = @unitId,
		waste = @waste,
		keywords = @keywords
    WHERE id = @id
END
GO
