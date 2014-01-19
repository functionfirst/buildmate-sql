USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskAdditionTypes]    Script Date: 01/08/2014 21:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Get all task addition types
-- =============================================
CREATE PROCEDURE [dbo].[getTaskAdditionTypes] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT * FROM TaskAdditionType
END
GO
