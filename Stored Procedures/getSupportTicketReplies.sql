USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSupportTicketReplies]    Script Date: 01/08/2014 21:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Get support ticket replies
-- =============================================
CREATE PROCEDURE [dbo].[getSupportTicketReplies]
	-- Add the parameters for the stored procedure here
	@ticketId INT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT repContent, repDate, name, SupportReplies.userId, SupportTickets.userId AS mainUserId
	FROM SupportReplies
	LEFT JOIN UserProfile ON SupportReplies.userId = UserProfile.userId
	LEFT JOIN SupportTickets ON SupportTickets.id = SupportReplies.ticketId
	WHERE ticketId = @ticketId AND SupportTickets.userId = @userId
	ORDER BY repDate
END
GO
