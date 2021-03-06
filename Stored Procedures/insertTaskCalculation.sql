USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertTaskCalculation]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 20th November 2008
-- Description:	Inserts new calculation based on related taskId
-- =============================================
CREATE PROCEDURE [dbo].[insertTaskCalculation]
	-- Add the parameters for the stored procedure here
	@taskid BIGINT,
	@length FLOAT,
	@width FLOAT,
	@height FLOAT,
	@multiplier FLOAT,
	@subtract TINYINT,
	@comment VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @id BIGINT
	SET @id = 0

    -- check taskid is set
	IF isNumeric(@taskId) = 1
	BEGIN
		-- grab the global id
		SELECT @id = id FROM TaskGlobalCalculation WHERE taskId = @taskId

		-- no global exists yet so create the new record for it
		If @id = 0
		BEGIN
			-- insert global
			INSERT INTO TaskGlobalCalculation (taskId) VALUES(@taskId); SELECT @id = SCOPE_IDENTITY()
		END

		-- insert new calculation
		INSERT INTO TaskCalculation (globalId, length, width, height, multiplier, subtract, comment)
		VALUES(@id, @length, @width, @height, @multiplier, @subtract, @comment)

	END
END
GO
