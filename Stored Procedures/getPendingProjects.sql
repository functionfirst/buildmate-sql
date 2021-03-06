USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getPendingProjects]    Script Date: 01/08/2014 21:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 4th March 2009
-- Description:	Gets any pending tenders for this user
-- =============================================
CREATE PROCEDURE [dbo].[getPendingProjects] 
	-- Add the parameters for the stored procedure here
	@userID UNIQUEIDENTIFIER,
	@days INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id, projectName, returndate, datediff(d, getdate(), returnDate) AS daystogo
	FROM Project
	WHERE userId = @userid
		AND dateDiff(d, getdate(), returnDate) <= @days
		AND  dateDiff(d, getdate(), returnDate) >= 0
		AND (projectStatusId = 1 OR projectStatusId = 2 OR projectStatusId = 9)
	ORDER BY datediff(d, getdate(), returnDate)
END
GO
