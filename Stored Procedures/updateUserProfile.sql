USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateUserProfile]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 25th January 2010
-- Description:	update users contact details
-- =============================================
CREATE PROCEDURE [dbo].[updateUserProfile]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@name VARCHAR(255),
	@jobtitle VARCHAR(120),
	@address VARCHAR(255),
	@postcode VARCHAR(20),
	@tel VARCHAR(20),
	@fax VARCHAR(20),
	@mobile VARCHAR(20),
	@business VARCHAR(8),
	@extension VARCHAR(8)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE UserProfile
	SET
		[name] = @name,
		[address] = @address,
		postcode = @postcode,
		jobtitle = @jobtitle,
		tel = @tel,
		fax = @fax,
		mobile = @mobile,
		business = @business,
		extension = @extension
	WHERE userId = @userId
END
GO
