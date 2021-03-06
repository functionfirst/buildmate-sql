USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getAdhocAdditionsByProject]    Script Date: 01/08/2014 21:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th July 2012
-- Description:	Retrieve adhoc additions for the selected project
-- =============================================
CREATE PROCEDURE [dbo].[getAdhocAdditionsByProject]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
	,@pid INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
    SELECT * 
    FROM view_TaskAdditions
    WHERE userId = @userId AND projectId = @pid
END
GO
