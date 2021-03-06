USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSubscriptionDetailsByUserId]    Script Date: 01/08/2014 21:36:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 12th December 2011
-- Description:	Retrieve paypal subscription details for the user
-- =============================================
CREATE PROCEDURE [dbo].[getSubscriptionDetailsByUserId]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM SubscriptionDetails WHERE userId = @userId
END
GO
