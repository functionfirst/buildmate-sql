USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskDataWebService]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 20th November 2011
-- Description:	Web Service for retrieving TaskData
-- =============================================
CREATE PROCEDURE [dbo].[getTaskDataWebService]
	-- Add the parameters for the stored procedure here
	@parentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM TaskData Where parentId = @parentId ORDER BY taskName
END
GO
