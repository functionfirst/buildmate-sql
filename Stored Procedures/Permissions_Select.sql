USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[Permissions_Select]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 30th December 2013
-- Description:	Check permissions for the object and aggregate type
-- =============================================
CREATE PROCEDURE [dbo].[Permissions_Select]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@aggregate VARCHAR(20),
	@objectId INTEGER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNT(id)
	FROM Permission
	LEFT JOIN Aggregation ON Aggregation.id = aggregationId
	WHERE userId = @userId AND [aggregate] = @aggregate AND objectId = @objectId;
END
GO
