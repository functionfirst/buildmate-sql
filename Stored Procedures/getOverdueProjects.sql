USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getOverdueProjects]    Script Date: 01/08/2014 21:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 21st April 2009
-- Description:	Get any overdue tenders for this user
-- =============================================
CREATE PROCEDURE [dbo].[getOverdueProjects] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id, projectName, returnDate
	FROM Project
	WHERE userId = @userid
		AND dateDiff(d, getdate(), returnDate) < 0
		AND (projectStatusid = 1 or projectStatusid = 2 or projectStatusid = 9)
	ORDER BY datediff(d, getdate(), returnDate)
END
GO
