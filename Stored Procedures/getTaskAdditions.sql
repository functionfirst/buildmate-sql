USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskAdditions]    Script Date: 01/08/2014 21:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 11th August 2011
-- Description:	Retrieve a list of all adhoc additions for this task
-- =============================================
CREATE PROCEDURE [dbo].[getTaskAdditions] 
	-- Add the parameters for the stored procedure here
	@taskId INT,
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * 
    FROM view_TaskAdditions
    WHERE userId = @userId AND taskId = @taskId
END
GO
