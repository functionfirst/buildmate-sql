USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectStatusByProject]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Get project statuses for this project
-- =============================================
CREATE PROCEDURE [dbo].[getProjectStatusByProject]
	-- Add the parameters for the stored procedure here
	@projectId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id, [status]
	FROM ProjectStatus
	ORDER BY setorder
END
GO
