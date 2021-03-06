USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getUserProfileNotifications]    Script Date: 01/08/2014 21:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:Get the notification settings for this user
-- =============================================
CREATE PROCEDURE [dbo].[getUserProfileNotifications] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT notifyByEmail FROM UserProfile WHERE userId = @userId
END
GO
