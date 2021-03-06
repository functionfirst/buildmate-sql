USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertUserProfile]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd October 2011
-- Description:	Inserts user profile data for a newly created account
-- =============================================
CREATE PROCEDURE [dbo].[insertUserProfile] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@name VARCHAR(120),
	@company VARCHAR(120),
	@address VARCHAR(255),
	@city VARCHAR(50),
	@county VARCHAR(50),
	@postcode VARCHAR(8),
	@tel VARCHAR(20),
	@mobile VARCHAR(20),
	@email VARCHAR(120)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO UserProfile(
		userId, name, company, [address], city, county, postcode, tel, mobile, email, help, subscription, vat
	) VALUES(
		@userId, @name, @company, @address, @city, @county, @postcode, @tel, @mobile, @email, 1, dateAdd(d, 30, getdate()), 20
	)
END
GO
