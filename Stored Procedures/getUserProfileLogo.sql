USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserProfileLogo]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get the users logo
-- =============================================
CREATE PROCEDURE [dbo].[getUserProfileLogo]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT logo FROM UserProfile WHERE userId = @userId
END
GO
