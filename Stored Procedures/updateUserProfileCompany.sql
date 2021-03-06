/****** Object:  StoredProcedure [dbo].[updateUserProfileCompany]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 25th January 2010
-- Description:	Update users company details
-- =============================================
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'updateUserProfileCompany' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
	EXEC ('DROP PROCEDURE dbo.updateUserProfileCompany')
GO

CREATE PROCEDURE [dbo].[updateUserProfileCompany]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@company VARCHAR(120),
	@vatNumber VARCHAR(20),
	@vat FLOAT,
	@defaultOverhead FLOAT,
	@defaultProfit FLOAT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE UserProfile
	SET
		company = @company,
		vatNumber = @vatNumber,
		vat = @vat,
		defaultOverhead = @defaultOverhead,
		defaultProfit = @defaultProfit
	WHERE userId = @userId
END
GO
