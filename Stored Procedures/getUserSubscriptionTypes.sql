USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserSubscriptionTypes]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get user subscription types
-- =============================================
CREATE PROCEDURE [dbo].[getUserSubscriptionTypes] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id, subscription FROM UserSubscriptionType
END
GO
