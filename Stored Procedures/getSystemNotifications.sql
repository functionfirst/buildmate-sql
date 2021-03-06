USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getSystemNotifications]    Script Date: 01/08/2014 21:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 22nd October 2012
-- Description:	Get most recent system notifications
-- =============================================
CREATE PROCEDURE [dbo].[getSystemNotifications]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 5 *
	FROM SystemNotification
	WHERE
		GETDATE() >= DateStart
		AND GETDATE() <= DateAdd(d, 14, DateStart)
		AND Hidden = 0
	ORDER BY DateStart DESC, DateCreated DESC
END
GO
