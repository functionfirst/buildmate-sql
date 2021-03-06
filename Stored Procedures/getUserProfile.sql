USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserProfile]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 8th March 2009
-- Description:	Retrieve user profile data
--				for the selected user
-- =============================================
CREATE PROCEDURE [dbo].[getUserProfile]  
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		[name],
		jobtitle,
		[address],
		postcode,
		tel,
		fax,
		mobile,
		business,
		extension
	FROM UserProfile
	WHERE userId = @userid
END
GO
