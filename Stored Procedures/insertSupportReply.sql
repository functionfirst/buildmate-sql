USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertSupportReply]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 10th October 2011
-- Description:	Add a reply to a support ticket
-- =============================================
CREATE PROCEDURE [dbo].[insertSupportReply]
	-- Add the parameters for the stored procedure here
	@ticketId INT,
	@userId UNIQUEIDENTIFIER,
	@repContent VARCHAR(1000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO SupportReplies(ticketId, userId, repContent, repDate)
    VALUES(@ticketId, @userId, @repContent, getdate())
END
GO
