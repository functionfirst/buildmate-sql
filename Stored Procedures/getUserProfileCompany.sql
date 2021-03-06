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
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'getUserProfileCompany' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
	EXEC ('DROP PROCEDURE dbo.getUserProfileCompany')
GO

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
		vatnumber,
		ISNULL(defaultOverhead, 0) AS defaultOverhead,
		ISNULL(defaultProfit, 0) AS defaultProfit
	FROM UserProfile
	WHERE userId = @userid
END
GO
