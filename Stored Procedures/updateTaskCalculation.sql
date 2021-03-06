USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateTaskCalculation]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Update the Task calculation
-- =============================================
CREATE PROCEDURE [dbo].[updateTaskCalculation]
	-- Add the parameters for the stored procedure here
	@length FLOAT,
	@width FLOAT,
	@height FLOAT,
	@multiplier FLOAT,
	@subtract TINYINT,
	@comment VARCHAR(50),
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE TaskCalculation
	SET length = @length, width = @width, height = @height,
	multiplier = @multiplier, subtract = @subtract, comment = @comment
	WHERE id = @id
END
GO
