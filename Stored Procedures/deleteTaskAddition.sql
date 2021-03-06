USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[deleteTaskAddition]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Delete Task addition
-- =============================================
CREATE PROCEDURE [dbo].[deleteTaskAddition]
	-- Add the parameters for the stored procedure here
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM TaskAddition WHERE id = @id
END
GO
