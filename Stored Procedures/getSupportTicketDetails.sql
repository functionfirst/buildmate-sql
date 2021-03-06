USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSupportTicketDetails]    Script Date: 01/08/2014 21:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get support ticket details
-- =============================================
CREATE PROCEDURE [dbo].[getSupportTicketDetails]
	-- Add the parameters for the stored procedure here
	@ticketId INT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT SupportTickets.id, isLocked, dateCreated, subject, content, name
	FROM SupportTickets
	LEFT JOIN UserProfile ON SupportTickets.userId = UserProfile.userId
	WHERE SupportTickets.userId = @userId AND SupportTickets.id = @ticketId
END
GO
