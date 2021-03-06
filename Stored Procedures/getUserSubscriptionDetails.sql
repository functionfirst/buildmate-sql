USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserSubscriptionDetails]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 23rd August 2012
-- Description:	Get paypal subscription details stored for this user
-- =============================================
CREATE PROCEDURE [dbo].[getUserSubscriptionDetails] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM UserSubscriptionDetails WHERE UserId = @userId
END
GO
