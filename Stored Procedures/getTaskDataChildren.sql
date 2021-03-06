USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskDataChildren]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 5th February 2011
-- Description:	Get the children of a specific task
-- =============================================
CREATE PROCEDURE [dbo].[getTaskDataChildren]
	-- Add the parameters for the stored procedure here
	@taskId INT,
	@showall TINYINT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @showall IS NULL
		BEGIN
			SELECT id, taskName, hidden
			FROM TaskData
			WHERE parentId = @taskId AND hidden=0 
			ORDER BY taskName
		END
	ELSE
		SELECT id, taskName, hidden
		FROM TaskData
		WHERE parentId = @taskId
		ORDER BY taskName
END
GO
