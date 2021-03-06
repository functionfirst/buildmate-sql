USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[Projects_STATISTICS]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 13th September 2011
-- Description:	Gets statistic project data for the selected user
-- =============================================
CREATE PROCEDURE [dbo].[Projects_STATISTICS] 
	-- Add the parameters for the stored procedure here
	@userID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		status,
		count(statusId) AS totalCount,
		round(isNull(sum(totalValue), 0),2) AS totalValue,
		totalProjects = 
		(
			SELECT count(id) FROM tblProjects WHERE userId = @userId
		),
		thisWeekValue =
		(
			SELECT isNull(sum(totalValue), 0)
			FROM tblProjects
			WHERE userId = @userId AND (statusId = 4 OR statusId >= 8) AND returnDate >= dateAdd(d, -7, getdate())
		),
		thisMonthValue = 
		(
			SELECT isNull(sum(totalValue), 0)
			FROM tblProjects
			WHERE userId = @userId AND (statusId = 4 OR statusId >= 8) AND returnDate >= dateAdd(m, -1, getdate())
		),
		thisWeekLoss = 
		(
			SELECT isNull(sum(totalValue), 0)
			FROM tblProjects
			WHERE userId = @userId AND statusId = 7 AND returnDate >= dateAdd(d, -7, getdate())
		),
		thisMonthLoss = 
		(
			SELECT isNull(sum(totalValue), 0)
			FROM tblProjects
			WHERE userId = @userId AND statusId = 7 AND returnDate >= dateAdd(m, -1, getdate())
		),
		successRate = 
		(
			(100/(SELECT count(id) FROM tblProjects WHERE userId = @userId AND returnDate >= dateAdd(d, -7, getdate()))) *
			(SELECT count(id) FROM tblProjects WHERE userId = @userId AND (statusId = 4 or statusId >= 8) AND returnDate >= dateAdd(d, -7, getdate()))
		),
		successRateMonthly = 
		(
			(100/(SELECT count(id) FROM tblProjects WHERE userId = @userId AND returnDate >= dateAdd(m, -1, getdate()))) *
			(SELECT count(id) FROM tblProjects WHERE userId = @userId AND (statusId = 4 or statusId >= 8) AND returnDate >= dateAdd(m, -1, getdate()))
		)
		,
		lossRate = 
		(
			(100/(SELECT count(id) FROM tblProjects WHERE userId = @userId AND returnDate >= dateAdd(d, -7, getdate()))) *
			(SELECT count(id) FROM tblProjects WHERE userId = @userId AND statusId = 7 AND returnDate >= dateAdd(d, -7, getdate()))
		)
		,
		lossRateMonthly = 
		(
			(100/(SELECT count(id) FROM tblProjects WHERE userId = @userId AND returnDate >= dateAdd(m, -1, getdate()))) *
			(SELECT count(id) FROM tblProjects WHERE userId = @userId AND statusId = 7 AND returnDate >= dateAdd(m, -1, getdate()))
		)
	FROM tblProjects
	LEFT JOIN tblStatus ON tblProjects.statusId = tblStatus.id
	WHERE userId = @userId
	GROUP BY statusId, [status], isLocked, setorder
	ORDER BY isLocked, setorder


END
GO
