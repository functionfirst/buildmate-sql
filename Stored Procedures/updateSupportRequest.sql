USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateSupportRequest]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 9th October 2011
-- Description: Update the locked status of a Support Ticket
-- =============================================
CREATE PROCEDURE [dbo].[updateSupportRequest]
	-- Add the parameters for the stored procedure here
	@id INT,
	@isLocked BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE SupportTickets SET isLocked = @isLocked WHERE id = @id
END
GO
