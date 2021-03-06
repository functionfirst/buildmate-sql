USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserContactsByUser]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Get user contacts for this user
-- =============================================
CREATE PROCEDURE [dbo].[getUserContactsByUser]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		UserContact.id
		, UserContact.name AS customerName
		, fullAddress = (
		
			SELECT DISTINCT
				COALESCE ([address]+case when postcode is null Or postcode='' then '' else ', ' end, '') +
				COALESCE (postcode, '')
			FROM UserContact AS u WHERE u.id = UserContact.id
		)
		, postcode
	FROM UserContact
    WHERE (userId = @UserId)
    ORDER BY name
END
GO
