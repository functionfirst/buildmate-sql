USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[UserContact_GetByUserId]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 10th October 2013
-- Description:	Get all customers for the selected user
-- =============================================
CREATE PROCEDURE [dbo].[UserContact_GetByUserId]
	-- Add the parameters for the stored procedure here
	@userId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		UserContact.id
		, [name]
		, isNull(jobtitle, '') AS jobtitle
		, [address]
		, postcode
		, archived
	FROM UserContact
	WHERE UserContact.UserId = @userId
	ORDER BY name
END
GO
