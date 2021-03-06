USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectLogs]    Script Date: 01/08/2014 21:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
--- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Get logs for this project
-- =============================================
CREATE PROCEDURE [dbo].[getProjectLogs]
	-- Add the parameters for the stored procedure here
	@projectId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT note, created_at
	FROM ProjectLog
	LEFT JOIN ProjectStatus ON ProjectLog.statusId = ProjectStatus.id
	WHERE projectId = @projectId
	ORDER BY [created_at] DESC
END
GO
