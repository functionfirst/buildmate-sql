USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateUserProfileLogo]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Update the users logo
-- =============================================
CREATE PROCEDURE [dbo].[updateUserProfileLogo]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@image VARCHAR(120)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE UserProfile SET logo = @image WHERE userId = @userId
END
GO
