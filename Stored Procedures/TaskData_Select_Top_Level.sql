USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[TaskData_Select_Top_Level]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 25th November 2013
-- Description:	Select top level TaskData
-- =============================================
CREATE PROCEDURE [dbo].[TaskData_Select_Top_Level]
	-- Add the parameters for the stored procedure here
	@parentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		TaskData.id
		, TaskData.taskName
	FROM TaskData
	WHERE TaskData.ParentId IS NULL AND TaskData.hidden=0
	ORDER BY taskName
END
GO
