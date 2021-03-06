USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectRetentionType]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Get project retention types
-- =============================================
CREATE PROCEDURE [dbo].[getProjectRetentionType]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT id, retentionType FROM ProjectRetentionType
END
GO
