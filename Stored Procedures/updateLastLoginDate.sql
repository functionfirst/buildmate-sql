USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateLastLoginDate]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateLastLoginDate]
	-- Add the parameters for the stored procedure here
	@userID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblAdminUsers SET lastLoginDate = getdate() WHERE contactID = @userID
END
GO
