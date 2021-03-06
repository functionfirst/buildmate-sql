USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserNotificationsByUser]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd March 2012
-- Description:	Get notifications for this user.
-- =============================================
CREATE PROCEDURE [dbo].[getUserNotificationsByUser]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT top 10 UserNotification.id, title, UserNotification.[description]
	FROM UserNotification
	LEFT JOIN UserNotificationRecipient ON UserNotification.id = UserNotificationRecipient.noticeId
	WHERE UserNotificationRecipient.userId = @userId AND hasRead = 0 AND sendDate <= GETDATE()
	ORDER BY sendDate DESC
END
GO
