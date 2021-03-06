USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertSupportTicket]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 8th October 2011
-- Description: User submitting a new support ticket
-- =============================================
CREATE PROCEDURE [dbo].[insertSupportTicket]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@subject VARCHAR(255),
	@content VARCHAR(1000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
	 INSERT INTO SupportTickets (userId, subject, content, dateCreated, isLocked)
	 VALUES(@userId, @subject, @content, getdate(), 0);
	 SELECT SCOPE_IDENTITY()
END
GO
