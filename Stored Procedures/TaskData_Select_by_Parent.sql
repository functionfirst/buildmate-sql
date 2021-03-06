USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[TaskData_Select_by_Parent]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 25th November 2013
-- Description:	Select Tasks and and child data matching the selected parent task
-- =============================================
CREATE PROCEDURE [dbo].[TaskData_Select_by_Parent]
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
		, COUNT(Children.Id) AS HasChildren
	FROM TaskData
	LEFT JOIN TaskData Children ON TaskData.Id = Children.ParentId
	WHERE TaskData.ParentId = @parentId AND TaskData.hidden=0
	GROUP BY TaskData.Id, TaskData.taskName, TaskData.keywords
	ORDER BY HasChildren DESC, TaskData.id
END
GO
