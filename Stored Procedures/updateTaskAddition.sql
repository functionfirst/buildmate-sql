USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateTaskAddition]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Update Task addition
-- =============================================
CREATE PROCEDURE [dbo].[updateTaskAddition] 
	-- Add the parameters for the stored procedure here
	 @description VARCHAR(255)
	, @price MONEY
	, @percentage FLOAT
	, @adhocTypeId TINYINT
	, @id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE TaskAddition
	SET
		[description] = @description
		, price = @price
		, percentage = @percentage
		, adhocTypeId = @adhocTypeId
	WHERE id = @id
END
GO
