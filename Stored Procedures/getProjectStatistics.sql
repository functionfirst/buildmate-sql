USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectStatistics]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 26th January 2009
-- Description:	Gets statistic project data for the selected user
-- =============================================
CREATE PROCEDURE [dbo].[getProjectStatistics]
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
		, projectStatusId INT
		, projectId INT
		, projectStatus VARCHAR(20)
		, grandTotal MONEY
	)
	-- get all Projects except lost (ID = 7)
	INSERT INTO @costs(projectId, projectStatus, projectStatusId, grandTotal)
	SELECT Project.id, [status], ProjectStatus.id, 0
	FROM Project
	LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
	WHERE userId = @userId AND archived=0 AND projectStatusId NOT IN(7)
	
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

	--output the project data 
	SELECT projectStatusId, projectStatus AS [status], COUNT(projectId) AS totalCount, SUM(grandTotal) AS totalValue
	FROM @costs
	GROUP BY projectStatus, projectStatusId
END
GO
