USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[report_COMPANY_NO_VAT]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 18th September 2011
-- Description:	Get all associated project, customer and business data to create a Company with No VAT document
-- =============================================
CREATE PROCEDURE [dbo].[report_COMPANY_NO_VAT]
	-- Add the parameters for the stored procedure here
	@pid INT
	, @incVAT TINYINT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
	DECLARE @projectTotalCost MONEY, @vatCost MONEY, @userId UNIQUEIDENTIFIER, @vatRate FLOAT
	
	-- get user id
	SELECT @userId = userId, @vatRate = vatRate FROM Project WHERE id = @pid
	
	-- get project cost
	EXEC getProjectCosts @pid, @userId, 1, @projectTotalCost OUTPUT, @vatCost OUTPUT

	IF @incVAT <> 1
	BEGIN
		SET @projectTotalCost = @projectTotalCost - @vatCost
	END

    -- Insert statements for procedure here
	SELECT
		projectName
		, project.[description]
		, vatnumber
		, paymentTerm
		, totalValue = @projectTotalCost
		, tenderType
		, vatCost = @vatCost
		, GETDATE() AS currentDate
		, UserContact.[name] as customerName
		, UserContact.[address] AS customerAddress
		, UserContact.city AS customerCity
		, UserContact.county AS customerCounty
		, UserContact.postcode AS customerpostcode
		, UserContact.tel AS customerTel
		, dbo.HtmlEncode(UserProfile.company) AS busCompany
		, UserProfile.name AS busName
		, STUFF(
			COALESCE('' + dbo.HtmlEncode(NULLIF(UserProfile.company, '')), '') +
			COALESCE('<br />' + NULLIF(UserProfile.[Address], ''), '') +
			COALESCE('<br />' + NULLIF(UserProfile.postcode, ''), '') +
			COALESCE('<br /><strong>Tel:</strong> ' + NULLIF(UserProfile.tel, ''), '') +
			COALESCE('<br /><strong>Email:</strong> ' + NULLIF(UserProfile.email, ''), '') +
			COALESCE('<br /><strong>VAT No:</strong> ' + NULLIF(UserProfile.vatnumber, ''), ''),
			1, 0, '') AS businessDetails
		, STUFF( 
			COALESCE(' ' + NULLIF(UserContact.[name], ''), '') +
			COALESCE('<br />' + NULLIF(UserContact.[Address], ''), '') +
			COALESCE('<br />' + NULLIF(UserContact.postcode, ''), ''),
			1, 0, '') AS customerDetails
		, UserProfile.[address] AS busAddress
		, UserProfile.city AS busCity
		, UserProfile.county AS busCounty
		, UserProfile.postcode AS busPostcode
		, UserProfile.tel AS busTel
		, UserProfile.email AS busEmail
		, dbo.HtmlEncode(UserProfile.jobtitle) AS busJobtitle
		, 'http://buildmateapp.com/images/logos/' + UserProfile.logo AS busLogo
		, vatRate
	FROM Project
	LEFT JOIN UserProfile ON Project.userID = UserProfile.userid
	LEFT JOIN UserContact ON Project.customerID = UserContact.id
	LEFT JOIN ProjectPaymentTerm ON UserContact.paymentTermsId = ProjectPaymentTerm.id
	LEFT JOIN ProjectTenderType ON Project.tenderTypeId = ProjectTenderType.id
	WHERE Project.id = @pid
END
GO
