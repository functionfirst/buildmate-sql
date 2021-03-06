USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[UserContact_Update]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 10th October 2013
-- Description:	Updates customer details
-- =============================================
CREATE PROCEDURE [dbo].[UserContact_Update]
	-- Add the parameters for the stored procedure here
	@id BIGINT,
	@name VARCHAR(255),
	@company VARCHAR(80),	
	@jobtitle VARCHAR(80),
	@address VARCHAR(255),
	@postcode VARCHAR(8),
	@email VARCHAR(80),
	@tel VARCHAR(20),
	@mobile VARCHAR(20),
	@fax VARCHAR(20),
	@paymentTermsId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- Insert statements for procedure here
	UPDATE UserContact SET
		name = @name,
		company = @company,		
		jobtitle = @jobtitle, 
		[address] = @address, 
		postcode = @postcode, 
		tel = @tel, 
		fax = @fax, 
		mobile = @mobile, 
		email = @email, 
		paymentTermsId = @paymentTermsId
	WHERE id = @id
END
GO
