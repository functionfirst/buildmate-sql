USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[UserContact_Select]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 10th October 2013
-- Description:	Get customer contact data
-- =============================================
CREATE PROCEDURE [dbo].[UserContact_Select]
	-- Add the parameters for the stored procedure here
		@userId UNIQUEIDENTIFIER,
	@CustomerId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- Insert statements for procedure here
	SELECT
		UserContact.id
		, company
		, [name]
		, jobtitle
		, email
		, tel
		, fax
		, mobile
		, paymentTermsId
		, business
		, extension
		, [address]
		, postcode
		, paymentTerm
		, archived
	FROM UserContact
	LEFT JOIN ProjectPaymentTerm ON ProjectPaymentTerm.id = paymentTermsId
	WHERE UserContact.id = @customerId
	AND UserContact.userId = @userId
END
GO
