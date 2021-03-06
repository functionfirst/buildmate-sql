USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertTaskAddition]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Insert new task addition
-- =============================================
CREATE PROCEDURE [dbo].[insertTaskAddition]
	-- Add the parameters for the stored procedure here
	@taskId INT,
	@description VARCHAR(255),
	@price MONEY,
	@percentage FLOAT,
	@adhocTypeId TINYINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO TaskAddition(taskId, [description], price, percentage, adhocTypeId)
	VALUES(@taskId, @description, @price, @percentage, @adhocTypeId)
END
GO
