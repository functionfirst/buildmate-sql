USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectStatisticsByWeek]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th December 2011
-- Description:	Get project data analyis by week
-- =============================================
CREATE PROCEDURE [dbo].[getProjectStatisticsByWeek]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @id INT, @pid INT, @total MONEY
	
	-- create an initial table of projects
	DECLARE @costs AS TABLE(
		id INT PRIMARY KEY IDENTITY(1,1)
		, projectId INT
		, projectStatus VARCHAR(20)
		, returnDate DATETIME
		, grandTotal MONEY
	)
	INSERT INTO @costs(projectId, projectStatus, returnDate, grandTotal)
	SELECT Project.id, [status], returnDate, 0
	FROM Project
	LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
	WHERE userId = @userId AND archived=0
	
	-- for each project get the grandTotal
	SELECT @id = max(id) FROM @costs
	
	-- iterate through each project
	WHILE @id is not null
	BEGIN
		SELECT @pid = projectId FROM @costs WHERE id = @id
		
		EXEC  getProjectCosts @pid, @userId, 1, @total OUTPUT
		
		UPDATE @costs SET grandTotal = @total WHERE id = @id
		
			-- check if Resource loop is ended
		SELECT @id = max(id) FROM @costs WHERE id < @id
	END
	
	-- output stats
	SELECT
		DATEPART(YEAR, returnDate) AS 'Year',
		DATEPART(wk, returnDate) AS 'Week #',
		projectStatus AS [status], COUNT(projectId) AS totalCount, SUM(grandTotal) AS totalValue
	FROM @costs
	GROUP BY projectStatus, DATEPART(Year, returnDate), DATEPART(WK, returnDate)
	ORDER BY 1,2
END
GO
