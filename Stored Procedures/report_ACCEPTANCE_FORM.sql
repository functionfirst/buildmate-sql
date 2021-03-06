USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[report_ACCEPTANCE_FORM]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 18th September 2011
-- Description:	Get all associated project, customer and business data to create an Acceptance Form document
-- =============================================
CREATE PROCEDURE [dbo].[report_ACCEPTANCE_FORM] 
	-- Add the parameters for the stored procedure here
	@pid INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @projectTotalCost MONEY, @vatCost MONEY, @userId UNIQUEIDENTIFIER
	
	-- get user id
	SELECT @userId = userId FROM Project WHERE id = @pid
	
	-- get project cost
	EXEC getProjectCosts @pid, @userId, 1, @projectTotalCost OUTPUT, @vatCost OUTPUT

    -- Insert statements for procedure here
	SELECT
		projectName
		, vatnumber
		, paymentTerm
		, totalValue = @projectTotalCost
		, tenderType
		, GETDATE() AS currentDate
		, UserContact.[name] as customerName
		, UserContact.[address] AS customerAddress
		, UserContact.postcode AS customerpostcode
		, UserContact.tel AS customerTel
		, dbo.HtmlEncode(UserProfile.company) AS busCompany
		, UserProfile.[name] AS busName
		, UserProfile.[address] AS busAddress
		, UserProfile.postcode AS busPostcode
		, UserProfile.tel AS busTel
		, UserProfile.email AS busEmail
		, 'http://buildmateapp.com/images/logos/' + UserProfile.logo AS busLogo
	FROM Project
	LEFT JOIN UserProfile ON Project.userID = UserProfile.userid
	LEFT JOIN UserContact ON Project.customerID = UserContact.id
	LEFT JOIN ProjectPaymentTerm ON UserContact.paymentTermsId = ProjectPaymentTerm.id
	LEFT JOIN ProjectTenderType ON Project.tenderTypeId = ProjectTenderType.id
	WHERE Project.id = @pid AND Project.userId = @userId
END
GO
