USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTotalUnreadUserNotificationsByUser]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 3rd March 2012
-- Description:	Get unread notification count for this user.
-- =============================================
CREATE PROCEDURE [dbo].[getTotalUnreadUserNotificationsByUser]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @totalMessages INT, @newMessage BIT
	SELECT @totalMessages = count(UserNotification.id)
	FROM UserNotification
	LEFT JOIN UserNotificationRecipient ON UserNotification.id = UserNotificationRecipient.noticeId
	WHERE UserNotificationRecipient.userId = @userId AND sendDate <= GETDATE()
	
	
	SELECT @newMessage = hasRead
	FROM UserNotification
	LEFT JOIN UserNotificationRecipient ON UserNotification.id = UserNotificationRecipient.noticeId
	WHERE UserNotificationRecipient.userId = @userId AND sendDate <= GETDATE() AND hasRead = 0
	
	SELECT totalMessages = @totalMessages, newMessage = isnull(@newMessage,0)

END
GO
