USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[UserContact_Update]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 15th January 2014
-- Description:	Log event to user subscription log
-- =============================================
CREATE PROCEDURE [dbo].[UserSubscriptionLog_insert]
	-- Add the parameters for the stored procedure here
	@UserId UNIQUEIDENTIFIER
	, @ActionDescription VARCHAR(255)
	, @UserIPAddress VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO UserSubscriptionLog(UserId, ActionDescription, UserIPAddress) VALUES (@UserId, @ActionDescription, @UserIPAddress)
END
GO