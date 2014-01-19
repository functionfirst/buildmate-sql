USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserBusinessTypes]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get a list of business types
-- =============================================
CREATE PROCEDURE [dbo].[getUserBusinessTypes] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM UserBusinessType
END
GO
