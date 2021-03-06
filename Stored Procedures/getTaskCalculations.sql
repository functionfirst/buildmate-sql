USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskCalculations]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 20th November 2008
-- Description:	Get the calculations associated with the selected task
-- =============================================
CREATE PROCEDURE [dbo].[getTaskCalculations]
	-- Add the parameters for the stored procedure here
	@taskId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--INSERT INTO @myCalcs (id, length, width, height, multiplier, subtract, comment)
	--SELECT TaskCalculation.id, length, width, height, multiplier, subtract, comment
	--FROM TaskGlobalCalculation, TaskCalculation
	--WHERE TaskGlobalCalculation.id = globalId AND taskId = @taskId

	SELECT TaskCalculation.id, dimensions =
		CASE
			WHEN isNumeric(length) = 1 AND isnumeric(width) = 1 AND isNumeric(height) = 1 THEN CAST(length AS VARCHAR(20)) + ' x ' + CAST(width AS VARCHAR(20)) + ' x ' + CAST(height AS VARCHAR(20))
			WHEN isNumeric(length) = 1 AND isNumeric(width) = 1 THEN CAST(length AS VARCHAR(20)) + ' x ' + CAST(width AS VARCHAR(20))
			WHEN isNumeric(length) = 1 AND isNumeric(height) = 1 THEN CAST(length AS VARCHAR(20)) + ' x ' + CAST(height AS VARCHAR(20))
			WHEN isNumeric(width) = 1 AND isNumeric(height) = 1 THEN CAST(width AS VARCHAR(20)) + ' x ' + CAST(height AS VARCHAR(20))
			WHEN isNumeric(length) = 1 THEN CAST(length AS VARCHAR(20))
			WHEN isNumeric(width) = 1 THEN CAST(width AS VARCHAR(20))
			WHEN isNumeric(height) = 1 THEN CAST(height AS VARCHAR(20))
		END,
		length, width, height, multiplier, subtract, comment, total = 
		CASE
			WHEN subtract = 0 THEN isNull(length, 1) * isNull(width, 1) * isNull(height, 1) * isNull(multiplier, 1)
			WHEN subtract = 1 THEN isNull(length, 1) * isNull(width, 1) * isNull(height, 1) * isNull(multiplier, 1) - isNull(length, 1) * (isNull(width, 1) * isNull(height, 1) * isNull(multiplier, 1) * 2)
		END

	FROM TaskGlobalCalculation, TaskCalculation
	WHERE TaskGlobalCalculation.id = globalId AND taskId = @taskId
END
GO
