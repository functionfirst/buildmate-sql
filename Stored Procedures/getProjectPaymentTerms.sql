USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectPaymentTerms]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description: Get a list of payment terms
-- =============================================
CREATE PROCEDURE [dbo].[getProjectPaymentTerms]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [id], [paymentTerm] FROM ProjectPaymentTerm
END
GO
