USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[UserContact_Insert]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 10th October 2013
-- Description:	Inserts new Contact
-- =============================================
CREATE PROCEDURE [dbo].[UserContact_Insert]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@name VARCHAR(255) = '',
	@company VARCHAR(80),
	@jobtitle VARCHAR(80),
	@address VARCHAR(255) = '',
	@postcode VARCHAR(8),
	@email VARCHAR(120),
	@tel VARCHAR(20),
	@mobile VARCHAR(20),
	@fax VARCHAR(20),
	@paymentTermsId INT,
	@NewId BIGINT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO UserContact (userId, name, company, jobtitle, [address], postcode, tel, fax, mobile, email, paymentTermsId)
	VALUES(@userId, @name, @company, @jobtitle, @address, @postcode, @tel, @fax, @mobile, @email, @paymentTermsId)

	SELECT @NewId = SCOPE_IDENTITY()
END
GO
