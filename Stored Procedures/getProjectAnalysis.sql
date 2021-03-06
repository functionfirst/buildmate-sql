USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectAnalysis]    Script Date: 01/08/2014 21:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 15th November 2011
-- Description:	Gets project analysis data for the selected users projects
-- =============================================
CREATE PROCEDURE [dbo].[getProjectAnalysis] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @id INT, @pid INT, @total MONEY, @lessOneWeek DATETIME, @lessOneMonth DATETIME
	
	SET @lessOneWeek = DATEADD(d, -7, getdate())
	SET @lessOneMonth = DATEADD(m, -1, getdate())
	
	-- identify the current week and month numbers
	-- we'll match these against the project return date
	DECLARE @thisWeekNumber INT, @thisMonthNumber INT
	SET @thisWeekNumber = DATEPART(wk, getdate())
	SET @thisMonthNumber = DATEPART(m, getdate())

	-- create an initial table of projects
	DECLARE @analysis AS TABLE(
		id INT PRIMARY KEY IDENTITY(1,1)
		, projectId INT
		, total MONEY
		, modified_at DATETIME
		, won BIT
	)
	INSERT INTO @analysis(projectId, total, modified_at, won)
	SELECT Project.id, 0, modified_at
		, won = CASE Project.projectStatusId
			WHEN 4 THEN 1  -- In progress
			WHEN 7 THEN 0  -- Lost
			WHEN 8 THEN 1  -- Completed
			WHEN 10 THEN 1 -- Invoiced
			WHEN 11 THEN 1 -- Paid
		END
	FROM Project
	LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
	WHERE userId = @userId AND projectStatusId IN (4,7,8,10,11)
	
	-- for each project get the grandTotal
	SELECT @id = max(id) FROM @analysis
	
	-- iterate through each project
	WHILE @id is not null
	BEGIN
		SELECT @pid = projectId FROM @analysis WHERE id = @id
		
		EXEC getProjectCosts @pid, @userId, 1, @total OUTPUT
		
		UPDATE @analysis SET total = @total WHERE id = @id
		
		-- check if Resource loop is ended
		SELECT @id = max(id) FROM @analysis WHERE id < @id
	END

	DECLARE @thisWeekValue MONEY, @thisMonthValue MONEY, @thisWeekLoss MONEY, @thisMonthLoss MONEY
	DECLARE @successRate FLOAT, @successRateMonthly FLOAT, @lossRate FLOAT, @lossRateMonthly FLOAT, @weekProjects FLOAT, @monthProjects FLOAT
	
	SET @thisWeekValue = (
		SELECT ISNULL(SUM(total), 0)
		FROM @analysis WHERE won = 1 AND DATEPART(wk, modified_at) = @thisWeekNumber
	)

	SET @thisMonthValue = (
		SELECT ISNULL(SUM(total), 0)
		FROM @analysis WHERE won = 1 AND DATEPART(m, modified_at) = @thisMonthNumber
	)
	
	SET @thisWeekLoss = (
		SELECT ISNULL(SUM(total), 0)
		FROM @analysis WHERE won = 0 AND DATEPART(wk, modified_at) = @thisWeekNumber
	)
	
	SET @thisMonthLoss = (
		SELECT ISNULL(SUM(total), 0)
		FROM @analysis WHERE won = 0 AND DATEPART(m, modified_at) = @thisMonthNumber
	)
	
	SET @weekProjects = (SELECT count(*) FROM Project WHERE userID = @userId AND DATEPART(wk, modified_at) = @thisWeekNumber AND projectStatusId IN (4,7,8,10,11))
	SET @monthProjects = (SELECT count(*) FROM Project WHERE userID = @userId  AND DATEPART(m, modified_at) = @thisMonthNumber AND projectStatusId IN (4,7,8,10,11))
	

	IF @weekProjects > 0
	BEGIN
		SET @weekProjects = 100/@weekProjects
		
		SET @successRate = (
			(SELECT @weekProjects * count(won) FROM @analysis WHERE won = 1 AND DATEPART(wk, modified_at) = @thisWeekNumber)
		)
	
		SET @lossRate = (
			(SELECT @weekProjects * count(won) FROM @analysis WHERE won = 0 AND DATEPART(wk, modified_at) = @thisWeekNumber)
		)
	END
	
	IF @monthProjects > 0
	BEGIN
		SET @monthProjects = 100/@monthProjects
	
		SET @successRateMonthly = (
			(SELECT @monthProjects * count(won) FROM @analysis WHERE won = 1  AND DATEPART(m, modified_at) = @thisMonthNumber)
		)
		
		SET @lossRateMonthly = (
			(SELECT @monthProjects * count(won) FROM @analysis WHERE won = 0  AND DATEPART(m, modified_at) = @thisMonthNumber)
		)
	END
	
	SELECT
		thisWeekValue = isNull(@thisWeekValue, 0)
		, thisMonthValue = isNull(@thisMonthValue, 0)
		, thisWeekLoss = isNull(@thisWeekLoss, 0)
		, thisMonthLoss = isNull(@thisMonthLoss, 0)
		, successRate = isNull(@successRate, 0)
		, successRateMonthly = isNull(@successRateMonthly, 0)
		, lossRate = isNull(@lossRate, 0)
		, lossRateMonthly = isNull(@lossRateMonthly, 0)
END
GO
