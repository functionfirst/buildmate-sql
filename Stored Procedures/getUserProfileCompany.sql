USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserProfileCompany]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 25th January 2010
-- Description:	Select users company details
-- =============================================
CREATE PROCEDURE [dbo].[getUserProfileCompany]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	
		company,
		isnull(vat, 0) AS vat,
		vatnumber
	FROM UserProfile
	WHERE userId = @userid
END
GO
